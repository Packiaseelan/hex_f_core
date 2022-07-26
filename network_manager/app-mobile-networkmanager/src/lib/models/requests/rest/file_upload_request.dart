import 'dart:io';

import 'package:core/task/busy_type.dart';

import 'package:network_manager/models/requests/base_request.dart';
import 'package:network_manager/models/response/base_data_model.dart';

class FileUploadRequest extends BaseRequest {
  final File file;

  FileUploadRequest({
    required BaseDataModel data,
    required this.file,
    required String name,
    Map<String, dynamic>? variables,
    String endPoint = Constants.graphQLDefaultEndpointName,
    Map<String, String>? additionalHeaders,
    BusyType showBusy = BusyType.defaultIndicator,
    int showBusyDelayInMilliseconds = 0,
    CachePolicy cachePolicy = CachePolicy.none,
  }) : super(
          name: name,
          type: RequestType.fileUpload,
          data: data,
          additionalHeaders: additionalHeaders,
          parameters: variables,
          showBusy: showBusy,
          showBusyDelayInMilliseconds: showBusyDelayInMilliseconds,
          cachePolicy: cachePolicy,
        );
}
