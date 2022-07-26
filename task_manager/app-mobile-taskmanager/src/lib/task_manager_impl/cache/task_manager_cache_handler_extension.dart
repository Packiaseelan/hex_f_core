import 'dart:async';

import 'package:core/task/task_params.dart';
import 'package:network_manager/models/requests/base_request.dart';
import 'package:network_manager/models/response/base_data_model.dart';
import 'package:task_manager/stream_observer/data_change_observer_resolver.dart';
import 'package:task_manager/task_manager.dart';
import 'package:task_manager/task_manager_impl/data_change_observer/task_manager_data_change_observer_handler_extension.dart';

extension TaskManagerDataRequestCacheTaskHandler on TaskManager {
  Future<BaseDataModel?> inCache(Task task, CachePolicy cachePolicy) async {
    if (cachePolicy == CachePolicy.onDemand) {
      var cacheKey = task.cacheKey ?? task.apiIdentifier;
      final cachedResult = await executeLocalCacheTask(
        params: CacheTaskParams(
          type: TaskManagerCacheType.MEMORY_GET,
          readValues: [cacheKey],
        ),
      );
      if (cachedResult.containsKey(cacheKey) && cachedResult[cacheKey] != null) {
        final cachedNetworkResponse = cachedResult[cacheKey] as BaseDataModel;
        return Future.value(cachedNetworkResponse);
      }
    }

    return null;
  }

  Future saveToCache(
    String apiIdentifier,
    BaseDataModel response,
    CachePolicy cachePolicy,
  ) async {
    return executeLocalCacheTask(
      params: CacheTaskParams(
        type: TaskManagerCacheType.MEMORY_SET,
        writeValues: {apiIdentifier: response},
      ),
    );
  }

  Future<T> executeLocalCacheTask<T>({TaskParams? params}) async {
    final args = params as CacheTaskParams;
    final result = await cacheTaskResolver?.waitOnTask(args);

    // Notify the data observers when the cached data is cleaned up
    final cacheType = args.type;
    if (cacheType == TaskManagerCacheType.MEMORY_CLEAR) {
      final dataNotifierParams = <String, dynamic>{};
      args.clearKeys?.forEach((element) {
        dataNotifierParams[element] = null;
      });
      await executeWaitOnDataNotifierTask(
        params: DataChangeObserverTaskParams(
          type: DataNotifierTaskType.SET,
          setKeys: dataNotifierParams,
        ),
      );
    }
    return result;
  }
}
