import 'package:core/task/task_params.dart';
import 'package:task_manager/task_manager.dart';

extension TaskManagerDataRequestCacheTaskHandler on TaskManager {
  Future<dynamic> executeWaitOnDataNotifierTask({TaskParams? params}) async {
    return await dataChangeObserverTaskResolver?.waitOnTask(params);
  }
}
