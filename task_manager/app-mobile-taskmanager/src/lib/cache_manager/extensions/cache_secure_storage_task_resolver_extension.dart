import 'package:core/logging/logger.dart';
import 'package:task_manager/cache_manager/cache_task_resolver.dart';

extension CacheTaskSecureStorage on CacheTaskResolver {
  Future<bool> setToSecureStorage(Map<String, dynamic> dataMap) async {
    for (var key in dataMap.keys) {
      final value = dataMap[key];
      if (value != null) {
        await secureStorageService.set(key, value);
      } else {
        HexLogger.logError('Unable to set $key in secure storage, value was null');
      }
    }

    return true;
  }

  Future<Map<String, String?>> getFromSecureStorageWithKeys(List<String> keys) async {
    final newMap = <String, String?>{};
    for (var key in keys) {
      final result = await secureStorageService.get(key);
      newMap[key] = result as String?;
    }
    return newMap;
  }

  Future<Map<String, String?>> getFromSecureStorageWithKey(String key) async {
    return getFromSecureStorageWithKeys([key]);
  }
}
