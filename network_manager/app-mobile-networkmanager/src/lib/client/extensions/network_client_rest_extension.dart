import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as rest_response;
import 'package:core/performance_monitor/performance_monitor.dart';
import 'package:core/utils/extensions/string_extensions.dart';
import 'package:core/utils/extensions/list_extensions.dart';
import 'package:core/task/base_error.dart';
import 'package:core/logging/logger.dart';

import 'package:network_manager/client/network_client.dart';
import 'package:network_manager/configuration/config.dart';
import 'package:network_manager/models/requests/base_request.dart';
import 'package:network_manager/models/requests/rest/file_upload_request.dart';
import 'package:network_manager/models/requests/rest/rest_request.dart';
import 'package:network_manager/models/response/base_network_response.dart';

extension RestExtension on NetworkClient {
  Future<BaseNetworkResponse> executeRestReqest({
    required BaseRequest request,
    required Dio client,
    required Config config,
    String? sessionId,
    Options? options,
    String? endpoint,
    FormData? data,
  }) async {
    final environment = _environmentForAPI(
      name: request.name,
      environments: config.restEnvironments,
      mappingOverrides: config.gqlMappingOverrides,
    );

    logStartOfNetworkRequest(request);

    final headers = _addAdditionalHeaders(
      sessionId: sessionId,
      additionalHeaders: request.additionalHeaders,
      environment: environment,
    );
    try {
      Response<dynamic> result;

      if (request is FileUploadRequest) {
        result = await client
            .post(
          endpoint!,
          queryParameters: request.parameters,
          data: data,
          options: options,
        )
            .catchError((error) {
          if (error is DioError) {
            if (error.type == DioErrorType.connectTimeout) {
              throw error;
            }
          }
        });
      } else {
        result = await startNetworkRequest(
          request: request as RestRequest,
          path: environment.host,
          client: client,
          headers: headers,
        ).catchError((error) {
          if (error is DioError) {
            if (error.type == DioErrorType.connectTimeout) {
              throw error;
            }
          }
        });
      }

      if (result != null) {
        HexLogger.logDebug(
          '\n\nNetwork Response: ${request.name}, data: ${result.data}\n\n',
        );

        if (result.statusCode == 200 || result.statusCode! < 300) {
          request.data!.fromRawResponseToModel(result.data);
          logEndOfNetworkRequest(request);
          return Future.value(BaseNetworkResponse(data: request.data));
        }
      }
    } on TimeoutException catch (_) {
      return handleTimeout(request.name, client);
    } finally {
      logEndOfNetworkRequest(request);
      return Future.value(BaseNetworkResponse(data: request.data));
    }
  }

  Environment _environmentForAPI({
    required String name,
    required List<Environment> environments,
    required Map<String, String> mappingOverrides,
  }) {
    final environment = environments.firstOrNull((element) => element.name == name);
    return environment!;
  }

  Future<rest_response.Response> startNetworkRequest({
    required RestRequest request,
    required String path,
    required Dio client,
    required Map<String, String> headers,
  }) async {
    switch (request.type) {
      case RequestType.get:
        return await _standardGetRequest(
          path: path,
          client: client,
          headers: headers,
        ).catchError((error) {
          if (error is DioError) {
            if (error.type == DioErrorType.connectTimeout) {
              throw error;
            }
          }
        });
      case RequestType.post:
        return await _standardPostRequest(
          path: path,
          client: client,
          headers: headers,
          body: request.parameters,
        );
      default:
        throw Exception('There is no ${request.type}');
    }
  }

  Future<rest_response.Response> _standardGetRequest({
    required Dio client,
    required String path,
    required Map<String, String> headers,
  }) async {
    HexLogger.logDebug<NetworkClient>(
      'Sending GET request to the server for url: $path',
    );

    final response = await client.get(path, options: Options(headers: headers)).catchError((error) {
      if (error is DioError) {
        if (error.type == DioErrorType.connectTimeout) {
          throw error;
        }
      }
    });
    return response;
  }

  Future<rest_response.Response> _standardPostRequest({
    required Dio client,
    required String path,
    required Map<String, String> headers,
    Map<String, dynamic>? body,
  }) async {
    HexLogger.logDebug<NetworkClient>(
      'Sending POST request to the server for url: $path',
    );

    final response = await client.post(path, data: body, options: Options(headers: headers));
    return response;
  }

  Map<String, String> _addAdditionalHeaders({
    String? sessionId,
    Map<String, String>? additionalHeaders,
    required Environment environment,
  }) {
    Map<String, String> newHeaders = environment.headers ?? {};
    if (additionalHeaders != null) {
      newHeaders = additionalHeaders;
    }

    if (sessionId.isNotBlank()) {
      newHeaders['x-session-id'] = sessionId!;
    }

    return newHeaders;
  }

  BaseNetworkResponse handleTimeout(String name, Dio client) {
    PerformanceMonitor.track('$name${Constants.networkCallExceptionKey}', properties: {
      Constants.methodKey: name,
      Constants.messageKey: Constants.connectionTimeout,
      Constants.errorCodeKey: Constants.goneFishing,
    });
    if (client.options.responseType == DioErrorType.connectTimeout) {
      HexLogger.logDebug('${Constants.networkResponseTimeoutError}$name\n');
      return BaseNetworkResponse(
        error: const BaseError(
          errorCode: Constants.connectionTimeout,
          message: '',
        ),
      );
    }
    return BaseNetworkResponse(
      error: const BaseError(
        errorCode: Constants.connectionTimeout,
        message: '',
      ),
    );
  }
}
