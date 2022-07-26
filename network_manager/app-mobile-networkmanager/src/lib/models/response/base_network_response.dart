import 'package:core/task/base_error.dart';

import 'package:network_manager/models/response/base_data_model.dart';

class BaseNetworkResponse {
  final BaseDataModel? data;
  final Map<String, dynamic>? rawData;
  final BaseError? error;

  BaseNetworkResponse({this.data, this.rawData, this.error});
}
