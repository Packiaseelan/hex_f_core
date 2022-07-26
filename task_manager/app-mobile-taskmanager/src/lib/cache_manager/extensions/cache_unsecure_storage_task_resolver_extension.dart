import 'package:task_manager/cache_manager/cache_task_resolver.dart';

// Synchronous Operations
extension CacheTaskUnSecureStorageSynchronousResolver on CacheTaskResolver {
  Future<Map<String, String?>> getFromStorage(List<String> keys) async {
    final newMap = <String, String?>{};
    for (var key in keys) {
      final value = await unsecureStorageService.get(key);
      newMap[key] = value as String?;
    }
    return newMap;
  }

  Future<bool> setToStorage(Map<String, dynamic> dataMap) async {
    final keys = dataMap.keys.toList();
    for (var key in keys) {
      var value = dataMap[key];
      await unsecureStorageService.set(key, value);
    }
    return true;
  }

  Future<bool> clearFromStorage(String key) async {
    final result = await unsecureStorageService.delete(key);
    return result;
  }
}
