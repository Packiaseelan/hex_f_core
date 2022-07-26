import 'package:core/task/task_params.dart';

enum UserSessionServiceType {
  start,
  end,
}

class UserSessionServiceParams extends TaskParams {
  final UserSessionServiceType type;
  final int? sessionTimeout;
  final bool? showTimeoutMessage;
  final Map<String, dynamic>? requestData;

  UserSessionServiceParams({
    required this.type,
    this.sessionTimeout,
    this.showTimeoutMessage,
    this.requestData,
  });
}
