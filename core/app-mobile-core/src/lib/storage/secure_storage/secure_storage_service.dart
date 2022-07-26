import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:core/storage/i_storage_service.dart';

/// A mini-service for securely storing string-based values.
///
/// Stores the information in keychain for iOS and uses keystore to encrypt on
/// Android.
class SecureStorageService implements IStorageService {
  final storage = const FlutterSecureStorage();

  @override
  Future<String?> get(String key) async => await storage.read(key: key);

  @override
  Future set(
    String key,
    dynamic value, {
    StreamController? streamController,
  }) async {
    if (value is String?) {
      if (value == null || value == '') {
        await storage.delete(key: key);
      } else {
        await storage.write(key: key, value: value);
      }
    } else {
      throw Exception(['Value isn\'t of type String?']);
    }
  }

  @override
  Future deleteAll() async {
    await storage.deleteAll();
  }

  @override
  Future delete(String key) async {
    await storage.delete(key: key);
  }
}
