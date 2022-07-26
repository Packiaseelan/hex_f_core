import 'package:core/ioc/di_container.dart';
import 'package:core/performance_monitor/performance_monitor.dart';
import 'package:core/utils/extensions/iterable_extensions.dart';
import 'package:network_manager/client/i_network_client.dart';
import 'package:network_manager/models/requests/base_request.dart';
import 'package:network_manager/models/requests/graph_ql/graphql_request.dart';
import 'package:network_manager/network_manager.dart';
import 'package:task_manager/task_manager.dart';
import 'package:task_manager/task_manager_impl/cache/task_manager_cache_handler_extension.dart';
import 'package:task_manager/task_manager_impl/data/task_manager_data_graphql_handler_extension.dart';

extension TaskManagerDataRequestGraphQLTaskHandler on TaskManager {
  Future executeAppLaunchDataOperation(List<Task> taskList) async {
    final List<GraphQLRequest> requestList = [];
    for (var task in taskList) {
        requestList.add(getRequest(identifier: task.apiIdentifier, taskParams: task.parameters));
      }

    var combinedQuery = 'query {';
    for (var request in requestList) {
      combinedQuery += request.request;
    }

    combinedQuery += '}';

    // Make the network call
    final client = DIContainer.container<INetworkClient>(
      NetworkManager.networkClientKey,
    );

    final graphQLRequest = GraphQLRequest(
      data: requestList.first.data!,
      request: combinedQuery,
      type: RequestType.query,
      name: 'app-launch-combined',
      showBusy: requestList.first.showBusy,
    );

    await client.runGraphQLRequest(request: graphQLRequest).then(
      (value) async {
        await handleSuccess(
          data: value.rawData!,
          combinedRequest: graphQLRequest,
          taskList: taskList,
          requestList: requestList,
        );

        Future.value(value.data);
      },
    );
  }

  Future handleSuccess({
    required Map<String, dynamic> data,
    required GraphQLRequest combinedRequest,
    required List<Task> taskList,
    required List<GraphQLRequest> requestList,
  }) async {
    PerformanceMonitor.startTimedEvent('AppLaunchAPICall-save_to_cache');
    taskList.forEachIndexed((task, index) async {
      final request = requestList[index];
      request.data!.fromJsonToModel(data);
      await saveToCache(task.apiIdentifier, request.data!, request.cachePolicy);
    });

    PerformanceMonitor.endTimedEvent('AppLaunchAPICall-save_to_cache');
    PerformanceMonitor.endTimedEvent('AppLaunchAPICall');
    PerformanceMonitor.track('AppLaunchAPICall-End');
  }
}
