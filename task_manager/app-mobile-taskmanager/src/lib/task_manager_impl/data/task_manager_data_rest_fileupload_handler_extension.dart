import 'package:core/ioc/di_container.dart';
import 'package:core/logging/logger.dart';
import 'package:core/task/task_params.dart';
import 'package:network_manager/client/i_network_client.dart';
import 'package:network_manager/client/i_service.dart';
import 'package:network_manager/models/requests/rest/file_upload_request.dart';
import 'package:network_manager/network_manager.dart';
import 'package:task_manager/task_manager.dart';

extension TaskManagerDataRequestFileUploadTaskHandler on TaskManager {
  Future handleRestFileUploadTask(Task task) async {
    try {
      final client = DIContainer.container<INetworkClient>(
        NetworkManager.networkClientKey,
      );

      final request = getRequest(identifier: task.apiIdentifier, taskParams: task.parameters);
      final value = await client.runFileUpload(request: request).catchError(
        (error) {
          throw error;
        },
      );
      return value.data;
    } catch (error, stacktrace) {
      HexLogger.logError('Failed to upload file with error: ${error.toString()}');
      HexLogger.logError('Stacktrace: ${stacktrace.toString()}');
    }
  }

  FileUploadRequest getRequest({
    required String identifier,
    Map<String, dynamic>? params,
    TaskParams? taskParams,
  }) {
    final service = DIContainer.container.resolve<IService>(identifier);
    return service.getFileUploadRequest(taskParams, paramsInMap: params);
  }
}
