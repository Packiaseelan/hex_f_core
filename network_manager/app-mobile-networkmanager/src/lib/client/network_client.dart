import 'dart:io';

import 'package:core/logging/logger.dart';
import 'package:core/performance_monitor/performance_monitor.dart';
import 'package:core/utils/extensions/list_extensions.dart';
import 'package:core/utils/extensions/string_extensions.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/io_client.dart';
import 'package:network_manager/auth/i_auth_manager.dart';
import 'package:network_manager/client/extensions/network_client_rest_extension.dart';
import 'package:network_manager/client/i_network_client.dart';
import 'package:network_manager/client/extensions/network_client_graphql_extension.dart';
import 'package:network_manager/client/mock/mock_network_client.dart';
import 'package:network_manager/configuration/config.dart';
import 'package:core/task/base_error.dart';
import 'package:network_manager/models/requests/graph_ql/graphql_request.dart';
import 'package:network_manager/models/requests/base_request.dart';
import 'package:network_manager/models/requests/rest/file_upload_request.dart';
import 'package:network_manager/models/requests/rest/rest_request.dart';
import 'package:network_manager/models/response/base_network_response.dart';

class NetworkClient implements INetworkClient {
  late Map<String, GraphQLClient> _graphQLClients;
  late Config config;
  final IAuthManager _authManager;
  late Dio _restClient;
  late MockNetworkClient mockNetworkClient;

  NetworkClient(this._authManager);

  @override
  Future<void> initializeGraphQlClient({
    required String accessTokenKey,
    required Config config,
    Map<String, String>? headers,
    List<int>? certificateBytes,
    bool disableCertificatePinning = false,
  }) async {
    this.config = config;

    SecurityContext? context;
    if (!disableCertificatePinning && certificateBytes != null) {
      context = SecurityContext();
      context.setTrustedCertificatesBytes(certificateBytes);
    }

    // Read the GraphQL Clients
    _graphQLClients = _createGraphQLClients(
      accessTokenKey: accessTokenKey,
      config: config,
      headers: headers,
      context: context,
    );

    // Create the REST client
    if (config.baseURL != null) {
      _restClient = _createRestClient(
        context,
        config,
        headers,
      );
    }

    if (kDebugMode) {
      mockNetworkClient = MockNetworkClient();
      await mockNetworkClient.readMappingOverrides();
    }

    // Check that we have a default GraphQL endpoint configured
    assert(_graphQLClients.isNotEmpty);
  }

  Map<String, GraphQLClient> _createGraphQLClients({
    required String accessTokenKey,
    required Config config,
    required Map<String, String>? headers,
    SecurityContext? context,
  }) {
    var clients = <String, GraphQLClient>{};
    final defaultEnvironment =
        config.gqlEnvironments.firstOrNull((element) => element.name == Constants.graphQLDefaultEndpointName);
    assert(defaultEnvironment != null,
        'There is no "${Constants.graphQLDefaultEndpointName}" GraphQLEndpoint configured in the network config');

    for (var env in config.gqlEnvironments) {
      // pin certificate to client
      final httpClient = HttpClient(context: context);
      final iocClient = IOClient(httpClient);

      var combinedHeaders = <String, String>{}..addAll(env.headers ?? {});

      if (headers != null) {
        combinedHeaders.addAll(headers);
      }

      // create http link
      final httpLink = HttpLink(
        env.host,
        defaultHeaders: combinedHeaders,
        httpClient: iocClient,
      );

      final authLink = AuthLink(
        getToken: () async {
          final accessTokenValue = await _authManager.getAccessToken() ?? '';
          return accessTokenValue.isBlank() ? '' : '$accessTokenKey $accessTokenValue';
        },
      ).concat(httpLink);

      final client = GraphQLClient(
        link: authLink,
        cache: GraphQLCache(),
      );
      clients[env.name] = client;
    }

    return clients;
  }

  Dio _createRestClient(
    SecurityContext? context,
    Config config,
    Map<String, String>? headers,
  ) {
    var combinedHeaders = <String, String>{};
    if (headers != null) {
      combinedHeaders.addAll(headers);
    }
    var options = BaseOptions(
      connectTimeout: Constants.timeOutValue * 1000,
      headers: combinedHeaders,
      baseUrl: config.baseURL!,
    );

    final client = Dio(options);
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      HttpClient httpClient = HttpClient(context: context);
      return httpClient;
    };

    return client;
  }

  @override
  Future<BaseNetworkResponse> runFileUpload({required FileUploadRequest request}) async {
    final localConfig = config.restEnvironments.firstOrNull((config) => config.name == request.name);
    if (localConfig == null) {
      throw 'No registered host for REST upload in assets/network_configuration_[environment].json!';
    }

    final headers = (localConfig.headers ?? {})..addAll(config.headers);
    final endpoint = localConfig.host;

    final multipartFile = await MultipartFile.fromFile(request.file.path, filename: request.file.uri.toString());

    final data = FormData.fromMap({
      'file': multipartFile,
    });

    final options = Options(headers: headers);

    return _runRestFileUpload(endpoint, request, data, options);
  }

  Future<BaseNetworkResponse> _runRestFileUpload(
    String endpoint,
    FileUploadRequest request,
    FormData data,
    Options options,
  ) async {
    return executeRestReqest(
      client: _restClient,
      endpoint: endpoint,
      request: request,
      data: data,
      options: options,
      config: config,
      sessionId: _authManager.sessionId(),
    );
  }

  @override
  Future<BaseNetworkResponse> runGraphQLRequest({required GraphQLRequest request}) async => await executeGraphQLReqest(
        request: request,
        clientList: _graphQLClients,
        sessionId: _authManager.sessionId(),
      );

  @override
  Future<BaseNetworkResponse?> runRestRequest({
    required RestRequest request,
  }) async {
    return await executeRestReqest(
      request: request,
      client: _restClient,
      config: config,
      sessionId: _authManager.sessionId(),
    ).catchError((error) {
      if (error is DioError) {
        if (error.type == DioErrorType.connectTimeout) {
          throw error;
        }
      }
    });
  }

  BaseNetworkResponse handleTimeout(String name) {
    PerformanceMonitor.track('$name${Constants.networkCallExceptionKey}', properties: {
      Constants.methodKey: name,
      Constants.messageKey: Constants.connectionTimeout,
      Constants.errorCodeKey: Constants.goneFishing,
    });
    HexLogger.logDebug('${Constants.networkResponseTimeoutError}$name\n');
    return BaseNetworkResponse(
      error: const BaseError(
        errorCode: Constants.connectionTimeout,
        message: '',
      ),
    );
  }

  void logStartOfNetworkRequest(BaseRequest request) {
    PerformanceMonitor.startTimedEvent(
      '${request.name}${Constants.networkCallKey}',
      properties: {
        Constants.methodKey: request.name,
      },
    );
  }

  void logEndOfNetworkRequest(BaseRequest request) {
    PerformanceMonitor.endTimedEvent(
      '${request.name}${Constants.networkCallKey}',
      properties: {
        Constants.methodKey: request.name,
      },
    );
  }
}
