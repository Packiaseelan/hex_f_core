import 'dart:io';

import 'package:core/task/task_params.dart';

class FileUploadTaskParams extends TaskParams {
  final String name;
  final File file;
  final Map<String, String> headers;
  final Map<String, dynamic> parameters;

  FileUploadTaskParams({
    this.name = 'default',
    required this.file,
    this.headers = const {},
    this.parameters = const {},
  });
}
