import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'package:network_manager/client/i_network_client.dart';
import 'package:network_manager/configuration/config.dart';
import 'package:network_manager/models/requests/graph_ql/graphql_request.dart';
import 'package:network_manager/models/requests/rest/file_upload_request.dart';
import 'package:network_manager/models/requests/rest/rest_request.dart';
import 'package:network_manager/models/response/base_network_response.dart';

/// How to use MockNetworkClient?
/// 1. Create `network-mocks` directory under `assets` in your package
/// 2. Register asset in your package pubspec.yaml
/// ```
///     flutter:
///       assets:
///         - assets/network-mocks/
/// ```
/// 3. For each response you want to mock add json file named after GraphQL request name (same you use in [GraphQLRequest.name])
///
//todo implement switching mock with configuration, not hardcoding MockNetworkClient in DI
//todo implement mock different responses for the same request
//todo implement developer tool to queue different responses for same request. F.E. error -> success -> different error
class MockNetworkClient extends INetworkClient {
  late Map<String, dynamic> responseMappingList;
  String _missingResponseMessage(GraphQLRequest request) => '''

Response mock for "${request.name}.json" is missing. Please make sure you have done the following:

  1. Created the file "${request.name}.json" under "assets/network-mocks" directory in your module
  2. Registered "assets/network-mocks" in your module pubspec.yaml.
  3. Deleted build directory and restarted the application

''';

  Future<void> readMappingOverrides() async {
    try {
      final contents = await rootBundle.loadString('assets/network-mocks/mock_entries.json', cache: false);
      final result = json.decode(contents) as Map<String, dynamic>;
      responseMappingList = result;
    } on Exception catch (exception) {
      print(exception.toString());
    }
  }

  @override
  void initializeGraphQlClient({
    required String accessTokenKey,
    required Config config,
    Map<String, String>? headers,
    List<int>? certificateBytes,
    bool disableCertificatePinning = false,
  }) {}

  @override
  Future<BaseNetworkResponse> runGraphQLRequest({required GraphQLRequest request}) async {
    final responseFileName = responseMappingList[request.name] as String?;
    if (responseFileName == null) {
      throw UnimplementedError("Add the ${request.name} entry in the mock_entries.json");
    }
    final result = await _loadJsonMap(responseFileName);
    request.data!.fromJsonToModel(result);
    return Future.value(BaseNetworkResponse(data: request.data, rawData: result));
  }

  @override
  Future<BaseNetworkResponse> runRestRequest({required RestRequest request,}) {
    throw UnimplementedError();
  }

  @override
  Future<BaseNetworkResponse> runFileUpload({required FileUploadRequest request}) {
    throw UnimplementedError();
  }

  Future<Map<String, dynamic>> _loadJsonMap(String responseFileName) async {
    final contents = await rootBundle.loadString('assets/network-mocks/$responseFileName.json');
    final result = json.decode(contents) as Map<String, dynamic>;
    return result;
  }
}
