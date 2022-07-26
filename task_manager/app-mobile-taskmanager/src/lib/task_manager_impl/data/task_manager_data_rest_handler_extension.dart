import 'package:core/ioc/di_container.dart';
import 'package:core/task/task_params.dart';
import 'package:network_manager/client/i_network_client.dart';
import 'package:network_manager/client/i_service.dart';
import 'package:network_manager/models/requests/rest/rest_request.dart';
import 'package:network_manager/models/response/base_data_model.dart';
import 'package:network_manager/network_manager.dart';
import 'package:task_manager/task_manager.dart';
import 'package:task_manager/task_manager_impl/cache/task_manager_cache_handler_extension.dart';

extension TaskManagerDataRequestRestTaskHandler on TaskManager {
  Future<BaseDataModel?> handleRestNetworkRequest<T>(
    Task task,
  ) async {
    final request = getRequest(identifier: task.apiIdentifier, taskParams: task.parameters);

    final cachedResult = await inCache(
      task,
      request.cachePolicy,
    );
    if (cachedResult != null) {
      return cachedResult;
    }
    final result = await _kickStartRequest<T>(request, task).catchError((error) {
      throw error;
    });

    return result;
  }

  RestRequest getRequest({
    required String identifier,
    Map<String, dynamic>? params,
    TaskParams? taskParams,
  }) {
    final service = DIContainer.container.resolve<IService>(identifier);
    return service.getRestRequest(taskParams, paramsInMap: params);
  }

  Future<BaseDataModel?> _kickStartRequest<T>(
    RestRequest request,
    Task task,
  ) async {
    // Make the network call
    final client = DIContainer.container<INetworkClient>(
      NetworkManager.networkClientKey,
    );
    final value = await client.runRestRequest(
      request: request,
    );
    if (value != null) {
      final response = value.data;
      final cacheKey = task.cacheKey ?? task.apiIdentifier;

      // Save to Cache
      await saveToCache(
        cacheKey,
        response!,
        request.cachePolicy,
      );

      return response;
    }
  }
}
