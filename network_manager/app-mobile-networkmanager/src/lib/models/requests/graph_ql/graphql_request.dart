import 'package:core/task/busy_type.dart';

import 'package:network_manager/models/requests/base_request.dart';
import 'package:network_manager/models/response/base_data_model.dart';

class GraphQLRequest extends BaseRequest {
  final String request;

  GraphQLRequest({
    required BaseDataModel data,
    required RequestType type,
    required String name,
    required this.request,
    Map<String, dynamic>? variables,
    String endPoint = Constants.graphQLDefaultEndpointName,
    Map<String, String>? additionalHeaders,
    BusyType showBusy = BusyType.defaultIndicator,
    int showBusyDelayInMilliseconds = 0,
    CachePolicy cachePolicy = CachePolicy.none,
  }) : super(
          name: name,
          type: type,
          data: data,
          additionalHeaders: additionalHeaders,
          parameters: variables,
          showBusy: showBusy,
          showBusyDelayInMilliseconds: showBusyDelayInMilliseconds,
          cachePolicy: cachePolicy,
        );
}
