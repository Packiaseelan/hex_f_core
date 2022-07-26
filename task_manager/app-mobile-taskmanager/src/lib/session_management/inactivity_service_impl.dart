import 'dart:async';

import 'package:core/session_management/inactivity_service.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:task_manager/cache_manager/cache_task_resolver.dart';
import 'package:task_manager/session_management/user_session/user_session_service.dart';
import 'package:task_manager/session_management/user_session/user_session_service_params.dart';
import 'package:task_manager/task_manager.dart';

class _Constants {
  static const inactivityTimeout = 10 * 60 * 1000; // 10 minutes in milliseconds
  static const storageKey = 'app-inactive-since';
  static const throttleTime = Duration(milliseconds: 1000);
}

/// Service to manage an inactivity timer that will logout the user when triggered.
class InactivityService extends IInactivityService {
  final int inactivityTimeout;
  final TaskManager taskManager;

  InactivityService({required this.taskManager, this.inactivityTimeout = _Constants.inactivityTimeout});

  Timer? _inactivityTimer;
  DateTime _inactiveStart = DateTime.now();

  // Internal flag to determine if the timer is considered active
  bool _timerIsActive = true;

  Duration? _inactivityDuration;
  StreamController<dynamic>? _controller;

  // Combines events from a stream and only emits one event during the Duration
  final throttle = StreamTransformer.fromBind((Stream<dynamic> s) => s.throttle(_Constants.throttleTime));

  @override
  void start() {
    _inactivityDuration = Duration(milliseconds: inactivityTimeout);
    _resetTimer(DateTime.now());

    _controller = StreamController();

    _controller?.stream.transform<dynamic>(throttle).listen((event) async {
      if (_timerIsActive) {
        _resetTimer(DateTime.now());
      }
    });
  }

  void dispose() {
    _timerIsActive = false;
    _inactivityTimer?.cancel();
    _controller?.close();
  }

  @override
  Future<bool> movedToBackground() async {
    await taskManager.waitForExecute(
      Task(
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.SECURE_SET,
          writeValues: {
            _Constants.storageKey: _inactiveStart.microsecondsSinceEpoch.toString(),
          },
        ),
        taskType: TaskType.CACHE_OPERATION,
      ),
    );

    return Future.value(true);
  }

  @override
  Future<bool> movedToForeground() async {
    final result = await taskManager.waitForExecute(
      Task(
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.SECURE_SET,
          readValues: [_Constants.storageKey],
        ),
        taskType: TaskType.CACHE_OPERATION,
      ),
    );

    final time = result?[_Constants.storageKey];

    DateTime? dt;
    if (time != null) {
      dt = DateTime.fromMicrosecondsSinceEpoch(int.tryParse(time) ?? 0);
    }

    _resetTimer(dt ?? DateTime.now());

    return Future.value(true);
  }

  void _resetTimer(DateTime startTime) {
    _inactivityTimer?.cancel();
    if (_inactivityDuration == null) {
      return;
    }
    if (startTime.add(_inactivityDuration!).isBefore(DateTime.now())) {
      // We've already timed out, perhaps as a result of being resumed.
      _timedOut();
    } else {
      _inactiveStart = startTime;
      _inactivityTimer = Timer(_inactivityDuration!, () => _timedOut());
    }
  }

  Future _timedOut() async {
    // Perform a 'logout'
    var newUserSessionTask = Task(
      taskType: TaskType.OPERATION,
      apiIdentifier: UserSessionService.identifier,
      parameters: UserSessionServiceParams(
        showTimeoutMessage: true,
        type: UserSessionServiceType.end,
      ),
    );
    return await taskManager.waitForExecute(newUserSessionTask);
  }

  @override
  void stopTimer() {
    _inactivityTimer?.cancel();
    _timerIsActive = false;
  }

  @override
  void startTimer() {
    _timerIsActive = true;
    _resetTimer(DateTime.now());
  }

  @override
  void registerInteraction(dynamic event) => _controller?.sink.add(event);
}
