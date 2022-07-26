import 'package:core/task/busy_type.dart';

import 'package:network_manager/models/response/base_data_model.dart';

enum RequestType {
  get,
  post,
  patch,
  delete,
  mutate,
  query,
  fileUpload,
}

enum CachePolicy {
  none,
  onDemand,
}

enum GraphQlRequestType {
  mutate,
  query,
}

class Constants {
  static const String defaultErrorCode = '0';
  static const String graphQLDefaultEndpointName = 'default';

  static const timeOutValue = 20;
  static const timeout = Duration(seconds: timeOutValue);

  static const String networkCallKey = '-NetworkCall';
  static const String networkCallExceptionKey = '-NetworkCall-Exception';
  static const String methodKey = 'method';
  static const String messageKey = 'message';
  static const String errorCodeKey = 'errorCode';
  static const String connectionTimeout = 'Connection timeout';
  static const String goneFishing = 'gone_fishing';
  static const String networkResponseTimeoutError = '\nNetwork Response Timeout error: ';
}

/// Base request for all subsequent requests.
///
/// Holds generic information for all requests.
class BaseRequest {
  BaseDataModel? data;

  /// The endpoint on the server you will be connecting to
  /// The name of the query/mutation that can be used to determine which endpoint to use.
  /// See the `src\assets\configuration\network_configuration.json` file for the endpoint
  /// mapping configuration
  /// Default value = 'default'
  final String name;

  /// The type of restful request you are making.
  /// Use either of mutate / Query for GraphQL requests
  final RequestType type;

  /// The headers that are custom to the request
  final Map<String, String>? additionalHeaders;

  /// The body parameters for REST network request;
  final Map<String, dynamic>? parameters;

  final CachePolicy cachePolicy;

  /// Show a 'busy' modal dialog to prevent user interaction
  final BusyType showBusy;

  /// The delay before showing a 'busy' modal dialog
  final int showBusyDelayInMilliseconds;

  BaseRequest({
    required this.name,
    required this.type,
    required this.data,
    required this.additionalHeaders,
    required this.parameters,
    required this.cachePolicy,
    required this.showBusy,
    required this.showBusyDelayInMilliseconds,
  });
}
