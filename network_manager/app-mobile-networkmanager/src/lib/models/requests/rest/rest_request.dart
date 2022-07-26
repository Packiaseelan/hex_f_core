import 'package:core/task/busy_type.dart';

import 'package:network_manager/models/requests/base_request.dart';
import 'package:network_manager/models/response/base_data_model.dart';

class RestRequest extends BaseRequest {
  RestRequest({
    required RequestType type,
    required String name,
    required BaseDataModel data,
    Map<String, dynamic>? body,
    Map<String, String>? additionalHeaders,
    BusyType showBusy = BusyType.defaultIndicator,
    int showBusyDelayInMilliseconds = 0,
    CachePolicy cachePolicy = CachePolicy.none,
  }) : super(
          name: name,
          type: type,
          data: data,
          additionalHeaders: additionalHeaders,
          parameters: body,
          showBusy: showBusy,
          showBusyDelayInMilliseconds: showBusyDelayInMilliseconds,
          cachePolicy: cachePolicy,
        );
}
