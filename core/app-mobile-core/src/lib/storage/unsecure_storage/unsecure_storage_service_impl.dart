import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:core/logging/logger.dart';
import 'package:core/storage/i_storage_service.dart';

class UnsecureStorageServiceImpl implements IStorageService {
  @override
  Future<bool> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var result = await prefs.remove(key);
    return result;
  }

  @override
  Future<bool> deleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    var result = await prefs.clear();
    return result;
  }

  @override
  Future<String?> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    HexLogger.logInfo('Retrieved from storage: $value');
    return value;
  }

  @override
  Future<bool> set(String key, dynamic value) async {
    if (value is String?) {
      if (value == null) {
        HexLogger.logInfo('$key not saved to storage, value was null.');
        return false;
      }
      final prefs = await SharedPreferences.getInstance();
      final result = await prefs.setString(key, value);
      HexLogger.logInfo('Saved to storage: $value');
      return result;
    } else {
      throw Exception(['Value isn\'t of type String?']);
    }
  }
}
