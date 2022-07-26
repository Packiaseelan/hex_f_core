import 'dart:async';

import 'package:task_manager/session_management/user_session/user_session_service.dart';
import 'package:task_manager/session_management/user_session/user_session_service_params.dart';
import 'package:task_manager/task_manager.dart';

import '../task_manager.dart';

class SessionTimeoutManager {
  final TaskManager taskManager;
  static Timer? _timer;

  SessionTimeoutManager({
    required this.taskManager,
  });

  void initNewSession(int sessionDuration) {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(minutes: sessionDuration), () {
      _timedOut();
    });
  }

  Future _timedOut() async {
    var newUserSessionTask = Task(
      taskType: TaskType.OPERATION,
      apiIdentifier: UserSessionService.identifier,
      parameters: UserSessionServiceParams(
        showTimeoutMessage: true,
        type: UserSessionServiceType.end,
      ),
    );
    await taskManager.waitForExecute(newUserSessionTask);
  }
}
