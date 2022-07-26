import 'package:network_manager/configuration/config.dart';
import 'package:network_manager/models/requests/graph_ql/graphql_request.dart';
import 'package:network_manager/models/requests/rest/file_upload_request.dart';
import 'package:network_manager/models/requests/rest/rest_request.dart';
import 'package:network_manager/models/response/base_network_response.dart';

abstract class INetworkClient {
  void initializeGraphQlClient({
    required String accessTokenKey,
    required Config config,
    Map<String, String>? headers,
    List<int>? certificateBytes,
    bool disableCertificatePinning,
  });

  /// Makes a Standard Request to an external API.
  ///
  /// [request] is generically typed to accept any type of request that belongs
  /// to the standard group of requests.
  Future<BaseNetworkResponse?> runRestRequest({required RestRequest request});

  /// Makes a GET Request using GraphQL to an external API.
  ///
  /// [request] contains the information necessary for the method to make a
  /// GET Request to the API.
  /// todo: complete generic implementation of graphql requests
  Future<BaseNetworkResponse> runGraphQLRequest({required GraphQLRequest request});

  Future<BaseNetworkResponse> runFileUpload({required FileUploadRequest request});
}
