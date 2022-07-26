import 'dart:io';

abstract class IFileStorageService {
  Future<File> getFile(String fileName);
  Future<void> deleteFile(String fileName);
  Future<File> createFile(String fileName, {required String content});
  Future<File> appendToFile(String fileName, {required String content});
  Future<void> deleteAll();
}
