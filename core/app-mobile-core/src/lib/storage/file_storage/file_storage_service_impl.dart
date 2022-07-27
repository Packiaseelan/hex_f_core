import 'dart:io';

import 'package:core/logging/logger.dart';
import 'package:core/storage/file_storage/i_file_storage_service.dart';
import 'package:path_provider/path_provider.dart';

/// Implementation of a file storage service.
///
/// Provides capability to CREATE, APPEND, GET & DELETE .txt files.
class FileStorageServiceImpl implements IFileStorageService {
  final fileDirectory = 'local_files';

  @override
  Future<File> createFile(String fileName, {required String content}) async {
    final file = await getFile(fileName);
    HexLogger.logInfo('Wrote to file: $fileName');
    return file.writeAsString(content);
  }

  @override
  Future<File> appendToFile(String fileName, {required String content}) async {
    final file = await getFile(fileName);
    HexLogger.logInfo('Appended to file: $fileName');
    return file.writeAsString(content);
  }

  /// Get a local file by it's name.
  /// Only works with .txt files.
  @override
  Future<File> getFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName.txt');
  }

  @override
  Future<void> deleteFile(String fileName) async {
    try {
      final file = await getFile(fileName);
      await file.delete();
      HexLogger.logInfo('Deleted File: $fileName');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      final localPath = await _localPath;
      final dir = Directory(localPath);
      dir.deleteSync(recursive: true);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Helpers

  /// Path to a directory where the application may place data that is user-generated, or that cannot otherwise be recreated by your application.
  /// Throws a MissingPlatformDirectoryException if the system is unable to provide the directory.
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path + fileDirectory;
    await Directory(path).create();
    return path;
  }
}
