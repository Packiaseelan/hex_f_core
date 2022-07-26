import 'dart:async';
import 'dart:io';

import 'package:core/storage/i_storage_service.dart';
import 'package:core/storage/file_storage/i_file_storage_service.dart';
import 'package:core/task/task_params.dart';
import 'package:core/task/i_task.dart';
import 'package:task_manager/cache_manager/extensions/cache_unsecure_storage_task_resolver_extension.dart';
import 'package:task_manager/cache_manager/extensions/cache_memory_storage_task_resolver_extension.dart';
import 'package:task_manager/cache_manager/extensions/cache_secure_storage_task_resolver_extension.dart';
import 'package:task_manager/task_manager.dart';

class _Constants {
  static final delayedCachedCall = 1;
}

class CacheTaskParams extends TaskParams {
  final TaskManagerCacheType type;
  final Map<String, dynamic>? writeValues;
  final List<String>? readValues;
  final List<String>? clearKeys;
  final int? delay;

  CacheTaskParams({
    required this.type,
    this.writeValues,
    this.readValues,
    this.clearKeys,
    this.delay,
  });
}

class CacheTaskResolver implements ITask {
  final IStorageService secureStorageService;
  final IFileStorageService fileStorageService;
  final IStorageService unsecureStorageService;
  final IStorageService memoryStorageService;

  CacheTaskResolver({
    required this.secureStorageService,
    required this.fileStorageService,
    required this.unsecureStorageService,
    required this.memoryStorageService,
  });

  @override
  Future waitOnTask<T>(TaskParams? parameters) async {
    final params = parameters as CacheTaskParams;
    switch (params.type) {
      case TaskManagerCacheType.SET:
        return await setToStorage(params.writeValues!);

      case TaskManagerCacheType.GET:
        return await getFromStorage(params.readValues!);

      case TaskManagerCacheType.CLEAR:
        return await clearFromStorage(params.clearKeys!.first);

      case TaskManagerCacheType.SECURE_SET:
        return setToSecureStorage(params.writeValues as Map<String, dynamic>);

      case TaskManagerCacheType.SECURE_GET:
        final keys = params.readValues;
        if (keys != null) {
          if (keys.length == 1) {
            return await getFromSecureStorageWithKey(keys.first);
          } else {
            return await getFromSecureStorageWithKeys(keys);
          }
        } else {
          throw Exception('Failed to fetch from secure storage. The keys list empty.');
        }
      case TaskManagerCacheType.MEMORY_SET:
        return await setToMemoryStorage(params.writeValues!);

      case TaskManagerCacheType.MEMORY_GET:
        return await getFromMemoryStorage(params.readValues!);

      case TaskManagerCacheType.MEMORY_CLEAR:
        var duration = _Constants.delayedCachedCall;
        if (params.delay != null) {
          duration = params.delay!;
        }
        await Future.delayed(Duration(seconds: duration), () {
          if (params.clearKeys != null) {
            if (params.clearKeys!.length > 1) {
              params.clearKeys!.forEach((k) {
                memoryStorageService.delete(k);
              });
            } else {
              memoryStorageService.delete(params.clearKeys!.first);
            }
          }
        });

        return Future.value(true);

      case TaskManagerCacheType.MEMORY_CLEAR_ALL:
        memoryStorageService.deleteAll();
        return Future.value(true);

      case TaskManagerCacheType.APPEND_TO_FILE:
        return _batchAppendToFiles(params.writeValues!);

      case TaskManagerCacheType.WRITE_FILE:
        return _batchCreateFiles(params.writeValues!);

      case TaskManagerCacheType.GET_FILE:
        return _batchGetFiles(params.readValues!);

      case TaskManagerCacheType.DELETE_FILE:
        return _batchDeleteFiles(params.clearKeys!);

      case TaskManagerCacheType.DELETE_ALL:
        return _deleteEverything();

      default:
        throw UnimplementedError(
            'Error: [$CACHE_TYPE] not found, can only accept ${TaskManagerCacheType.values.toString()} types');
    }
  }
}

/// Extension for Cache Task Resolver to perform the file operations
extension CacheTaskResolverFileOperations on CacheTaskResolver {
  Future<void> _deleteEverything() async {
    await secureStorageService.deleteAll();
    await memoryStorageService.deleteAll();
    await unsecureStorageService.deleteAll();
    await fileStorageService.deleteAll();
  }

  // Files
  Future<List<File>> _batchGetFiles(List<String> filesList) async {
    var files = <File>[];
    for (var file in filesList) {
      final readFile = await fileStorageService.getFile(file);
      files.add(readFile);
    }
    return files;
  }

  Future<List<File>> _batchAppendToFiles(Map<String, dynamic> dataMap) async {
    var files = <File>[];
    for (var key in dataMap.keys) {
      final file = await fileStorageService.createFile(key, content: dataMap[key] as String);
      files.add(file);
    }
    return files;
  }

  Future<List<File>> _batchCreateFiles(Map<String, dynamic> dataMap) async {
    var files = <File>[];
    for (var key in dataMap.keys) {
      final value = await fileStorageService.createFile(key, content: dataMap[key] as String);
      files.add(value);
    }
    return files;
  }

  Future<bool> _batchDeleteFiles(List<String> files) async {
    for (var file in files) {
      await fileStorageService.deleteFile(file);
    }
    return true;
  }
}
