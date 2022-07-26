import 'package:core/ioc/di_container.dart';
import 'package:core/performance_monitor/performance_monitor.dart';
import 'package:core/task/task_params.dart';
import 'package:task_manager/app_launch_data_operation/app_launch_data_operation_params.dart';
import 'package:core/task/i_task.dart';
import 'package:task_manager/task_manager.dart';
import 'package:task_manager/task_manager_impl/app_launch/task_manager_app_launch_extension.dart';
import 'package:task_manager/task_manager_impl/cache/task_manager_cache_handler_extension.dart';
import 'package:task_manager/task_manager_impl/data/task_manager_data_graphql_handler_extension.dart';
import 'package:task_manager/task_manager_impl/data/task_manager_data_rest_handler_extension.dart';
import 'package:task_manager/task_manager_impl/data/task_manager_data_rest_fileupload_handler_extension.dart';
import 'package:task_manager/task_manager_impl/data_change_observer/task_manager_data_change_observer_handler_extension.dart';

class TaskManager {
  bool isShowing = false;
  final runningNetworkRequests = <String>[];

  final ITask? dataChangeObserverTaskResolver;
  final ITask? cacheTaskResolver;

  TaskManager({
    this.dataChangeObserverTaskResolver,
    this.cacheTaskResolver,
  });

  Future waitForExecute<T>(Task task) async {
    switch (task.taskType) {
      case TaskType.OPERATION:
        return _handleOperation<T>(task.apiIdentifier, task.parameters);

      case TaskType.DATA_OPERATION:
        return _handleDataRequest<T>(
          task,
        ).catchError(
          (error) {
            throw error;
          },
        );

      case TaskType.CACHE_OPERATION:
        return await executeLocalCacheTask(params: task.parameters);

      case TaskType.DATA_NOTIFIER:
        return await executeWaitOnDataNotifierTask(params: task.parameters);

      case TaskType.APP_LAUNCH_DATA_OPERATION:
        PerformanceMonitor.track('AppLaunchAPICall-Start');
        PerformanceMonitor.startTimedEvent('AppLaunchAPICall');

        final taskList = task.parameters as AppLaunchDataOperationParams?;
        final length = taskList?.tasks?.length ?? 0;
        if (length > 0) {
          return executeAppLaunchDataOperation(taskList!.tasks!);
        }
        throw Exception('There is no ${task.taskType} implemented');

      default:
        throw Exception('There is no ${task.taskType} implemented');
    }
  }

  Future _handleOperation<T>(String identifier, TaskParams? params) {
    final service = DIContainer.container.resolve<ITask>(identifier);
    return service.waitOnTask<T>(params);
  }

  Future<dynamic> _handleDataRequest<T>(
    Task task,
  ) async {
    switch (task.subType) {
      case TaskSubType.GRAPHQL:
        final result = await handleGraphQLNetworkRequest<T>(task).catchError(
          (error) {
            throw error;
          },
        );
        return result;

      case TaskSubType.REST:
        final result = await handleRestNetworkRequest<T>(task).catchError(
          (error) {
            throw error;
          },
        );
        return result;

      case TaskSubType.REST_FILE_UPLOAD:
        return await handleRestFileUploadTask(task).catchError(
          (error) {
            throw error;
          },
        );

      default:
        throw Exception('There is no ${task.taskType} implemented');
    }
  }
}
