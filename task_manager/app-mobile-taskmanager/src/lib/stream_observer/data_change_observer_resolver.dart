import 'dart:async';

import 'package:core/performance_monitor/performance_monitor.dart';
import 'package:core/task/i_task.dart';
import 'package:core/task/task_params.dart';
import 'package:task_manager/task.dart';

class DataChangeObserverTaskParams extends TaskParams {
  final DataNotifierTaskType type;
  final List<String>? keys;
  final Map<String, dynamic>? setKeys;

  DataChangeObserverTaskParams({required this.type, this.keys, this.setKeys});
}

class DataChangeObserverTaskResolver implements ITask {
  final _streamControllers = <String, StreamController>{};

  @override
  Future<dynamic> waitOnTask<T>(TaskParams? parameters) async {
    final params = parameters as DataChangeObserverTaskParams;

    final type = params.type;

    PerformanceMonitor.track('DataNotifierTask-${type.toString()}-Start', properties: {'Type': type.toString()});

    switch (type) {
      case DataNotifierTaskType.ADD:
        var values = <String, StreamController>{};
        await Future.forEach(
          params.keys!,
          (dynamic key) async {
            final keyAsString = key as String;
            if (!(_streamControllers.containsKey(key))) {
              final newStreamController = StreamController();
              _streamControllers[keyAsString] = newStreamController;
              values[keyAsString] = newStreamController;
            } else {
              values[keyAsString] = _streamControllers[keyAsString]!;
            }
          },
        );

        return values;

      case DataNotifierTaskType.DELETE:
        await Future.forEach(
          params.keys!,
          (dynamic key) async {
            _closeStreamController(key);
          },
        );
        break;

      case DataNotifierTaskType.DELETE_ALL:
        await Future.forEach(
          params.keys!,
          (dynamic key) async {
            _closeStreamController(key);
          },
        );
        break;

      case DataNotifierTaskType.SET:
        await Future.forEach(
          params.setKeys!.entries,
          (dynamic key) async {
            if (_streamControllers.containsKey(key)) {
              final element = _streamControllers[key];
              element!.add({
                DATA_NOTIFIER_STATUS_KEY: DataNotifierStatus.REFRESH,
                DATA_NOTIFIER_PARAM_KEY: params.setKeys![DATA_NOTIFIER_PARAM_VALUES],
              });
            }
          },
        );
        break;

      default:
        throw UnimplementedError();
    }

    PerformanceMonitor.track('DataNotifierTask-${type.toString()}-End', properties: {'Type': type.toString()});
  }

  void _closeStreamController(dynamic key) {
    if (_streamControllers.containsKey(key)) {
      final streamController = _streamControllers[key];
      streamController?.close();
      _streamControllers.remove(key);
    }
  }
}
