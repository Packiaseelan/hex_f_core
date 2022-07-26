import 'package:task_manager/cache_manager/cache_task_resolver.dart';

// Memory Storage
extension CacheTaskSecureStorage on CacheTaskResolver {
  Future<bool> setToMemoryStorage(Map<String, dynamic> dataMap) async {
    for (var key in dataMap.keys) {
      final value = dataMap[key];
      if (value != null) {
        memoryStorageService.set(key, value);
      }
    }

    return true;
  }

  Future<Map<String, dynamic>> getFromMemoryStorage(List<String> keys) async {
    final newMap = <String, dynamic>{};
    for (var key in keys) {
      final result = memoryStorageService.get(key);
      if (result != null) {
        newMap[key] = result;
      }
    }

    return newMap;
  }
}
