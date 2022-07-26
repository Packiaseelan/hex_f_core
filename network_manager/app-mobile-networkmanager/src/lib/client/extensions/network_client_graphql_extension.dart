import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:core/performance_monitor/performance_monitor.dart';
import 'package:core/utils/extensions/string_extensions.dart';
import 'package:core/utils/extensions/list_extensions.dart';
import 'package:core/task/base_error.dart';
import 'package:core/logging/logger.dart';

import 'package:network_manager/client/mock/mock_network_client.dart';
import 'package:network_manager/client/network_client.dart';
import 'package:network_manager/models/requests/base_request.dart';
import 'package:network_manager/models/requests/graph_ql/graphql_request.dart';
import 'package:network_manager/models/response/base_network_response.dart';

extension GraphQLExtension on NetworkClient {
  Future<BaseNetworkResponse> executeGraphQLReqest({
    required GraphQLRequest request,
    required Map<String, GraphQLClient> clientList,
    String? sessionId,
  }) async {
    final graphQLClient = _clientForRequest(request.name, clientList);
    if (graphQLClient is MockNetworkClient) {
      final networkResponse = graphQLClient.runGraphQLRequest(request: request);
      return Future.value(networkResponse);
    }

    final client = graphQLClient as GraphQLClient;
    try {
      HexLogger.logDebug(
        '\n\nNetwork request: ${request.name}, ${request.request}, variables -- ${request.parameters.toString()}\n\n',
      );
      logStartOfNetworkRequest(request);

      final result = await startNetworkRequest(sessionId, request, client);

      HexLogger.logDebug(
        '\n\nNetwork Response: ${request.name}, variables -- ${request.parameters.toString()} --- data: ${result.data}\n\n',
      );

      if (!result.hasException && result.data != null) {
        request.data!.fromJsonToModel(result.data!);
        return Future.value(BaseNetworkResponse(data: request.data, rawData: result.data));
      }

      return _handleException(request, result);
    } on TimeoutException catch (_) {
      return handleTimeout(request.name);
    } finally {
      logEndOfNetworkRequest(request);
    }
  }

  Future<QueryResult> startNetworkRequest(String? sessionId, GraphQLRequest request, GraphQLClient client) async {
    switch (request.type) {
      case RequestType.mutate:
        return await _mutationBuilder(sessionId, request, client);
      case RequestType.query:
        return await _queryBuilder(sessionId, request, client);
      default:
        throw Exception('There is no ${request.type}');
    }
  }

  Future<QueryResult> _queryBuilder(String? sessionId, GraphQLRequest graphQLRequest, GraphQLClient client) => client
      .query(QueryOptions(
        document: gql(graphQLRequest.request),
        variables: graphQLRequest.parameters ?? {},
        context: _addAdditionalHeaders(sessionId, graphQLRequest.additionalHeaders),
      ))
      .timeout(Constants.timeout);

  Future<QueryResult> _mutationBuilder(String? sessionId, GraphQLRequest graphQLRequest, GraphQLClient client) => client
      .mutate(MutationOptions(
        document: gql(graphQLRequest.request),
        variables: graphQLRequest.parameters ?? {},
        context: _addAdditionalHeaders(sessionId, graphQLRequest.additionalHeaders),
      ))
      .timeout(Constants.timeout);

  dynamic _clientForRequest(String? name, Map<String, GraphQLClient> clients) {
    final gqlName = config.gqlMappingOverrides[name] ?? Constants.graphQLDefaultEndpointName;
    if (kReleaseMode) {
      return clients[gqlName];
    }

    if (clients.containsKey(gqlName)) {
      return clients[gqlName];
    }

    return mockNetworkClient;
  }

  Context? _addAdditionalHeaders(String? sessionId, Map<String, String>? additionalHeaders) {
    Map<String, String> newHeaders = {};
    if (additionalHeaders != null) {
      newHeaders = additionalHeaders;
    }

    if (sessionId.isNotBlank()) {
      newHeaders['x-session-id'] = sessionId!;
    }

    if (newHeaders.isNotEmpty) {
      final linkHeaders = HttpLinkHeaders(headers: newHeaders);
      return Context.fromMap({HttpLinkHeaders: linkHeaders});
    }

    return null;
  }

  BaseNetworkResponse _handleException(GraphQLRequest request, QueryResult result) {
    var message = '';
    String errorCode = Constants.defaultErrorCode;
    dynamic exception;
    if (result.hasException) {
      if (result.exception != null) {
        if (result.exception!.graphqlErrors.isNotEmpty && result.exception!.graphqlErrors.first.extensions != null) {
          HexLogger.logError(result.exception!.graphqlErrors.first.message);
          errorCode =
              result.exception!.graphqlErrors.first.extensions?['Code'] as String? ?? Constants.defaultErrorCode;
          exception = result.exception;
          message = result.exception!.graphqlErrors.first.message;
        } else if (result.exception!.linkException != null) {
          if (result.exception!.linkException!.originalException != null) {
            exception = result.exception!.linkException!.originalException;

            if (exception is SocketException /*&& !await hasConnection()*/) {
              errorCode = 'no_internet_access';
            }

            //we can't cast without checking the type,it will throw exception...
            //this can happen,for example, when there is no internet.Then it will be thrown
            //Unhandled Exception: type 'SocketException' is not a subtype of type 'FormatException?' in type cast
            final originalFormatException = exception is FormatException ? exception : null;

            HexLogger.logError(originalFormatException?.message ?? '');
            HexLogger.logError(originalFormatException?.source as String? ?? '');

            message = originalFormatException?.message ?? '';
          } else {
            //we have a link exception, but original message is null!
            if (result.exception is ServerException) {
              final serverException = result.exception as ServerException;
              message = serverException.parsedResponse?.errors?.firstOrNull((_) => true)?.message ?? '';
              serverException.parsedResponse?.errors?.forEach((element) {
                HexLogger.logError('Server Exception: ${element.message}');
              });
              exception = serverException;
            }
          }
        }
      }

      PerformanceMonitor.track('${request.name}${Constants.networkCallExceptionKey}', properties: {
        Constants.methodKey: request.name,
        Constants.messageKey: message,
        Constants.errorCodeKey: errorCode,
      });
    }

    return BaseNetworkResponse(
      error: BaseError(
        errorCode: errorCode,
        message: 'Could not read the network error response',
      ),
    );
  }
}
