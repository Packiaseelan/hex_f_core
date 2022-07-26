import 'package:core/task/task_params.dart';

import 'package:network_manager/models/requests/graph_ql/graphql_request.dart';
import 'package:network_manager/models/requests/rest/file_upload_request.dart';
import 'package:network_manager/models/requests/rest/rest_request.dart';

abstract class IService {
  GraphQLRequest getGraphQLRequest(TaskParams? params, {Map<String, dynamic>? paramsInMap}) {
    throw UnimplementedError();
  }

  RestRequest getRestRequest(TaskParams? params, {Map<String, dynamic>? paramsInMap}) {
    throw UnimplementedError();
  }

  FileUploadRequest getFileUploadRequest(TaskParams? params, {Map<String, dynamic>? paramsInMap}) {
    throw UnimplementedError();
  }
}

class BaseService implements IService {
  @override
  GraphQLRequest getGraphQLRequest(TaskParams? params, {Map<String, dynamic>? paramsInMap}) {
    throw UnimplementedError();
  }

  @override
  RestRequest getRestRequest(TaskParams? params, {Map<String, dynamic>? paramsInMap}) {
    throw UnimplementedError();
  }

  @override
  FileUploadRequest getFileUploadRequest(TaskParams? params, {Map<String, dynamic>? paramsInMap}) {
    throw UnimplementedError();
  }
}
