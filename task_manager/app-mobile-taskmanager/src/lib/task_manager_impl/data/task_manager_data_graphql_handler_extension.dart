import 'package:core/ioc/di_container.dart';
import 'package:core/task/task_params.dart';
import 'package:network_manager/client/i_network_client.dart';
import 'package:network_manager/client/i_service.dart';
import 'package:network_manager/models/requests/graph_ql/graphql_request.dart';
import 'package:network_manager/models/response/base_data_model.dart';
import 'package:network_manager/network_manager.dart';
import 'package:task_manager/task_manager.dart';
import 'package:task_manager/task_manager_impl/cache/task_manager_cache_handler_extension.dart';

extension TaskManagerDataRequestGraphQLTaskHandler on TaskManager {
  Future<BaseDataModel?> handleGraphQLNetworkRequest<T>(Task task) async {
    final request = getRequest(
      identifier: task.apiIdentifier,
      taskParams: task.parameters,
      params: task.paramsInMap,
    );

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

  GraphQLRequest getRequest({
    required String identifier,
    Map<String, dynamic>? params,
    TaskParams? taskParams,
  }) {
    final service = DIContainer.container.resolve<IService>(identifier);
    return service.getGraphQLRequest(taskParams, paramsInMap: params);
  }

  Future<BaseDataModel?> _kickStartRequest<T>(GraphQLRequest request, Task task) async {
    // Make the network call
    final client = DIContainer.container<INetworkClient>(
      NetworkManager.networkClientKey,
    );
    final value = await client.runGraphQLRequest(request: request).catchError((error) {
      throw error;
    });
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
