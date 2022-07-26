library network_manager;

import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:core/ioc/di_container.dart';
import 'package:core/storage/i_storage_service.dart';
import 'package:core/storage/secure_storage/secure_storage_service.dart';
import 'package:core/utils/extensions/string_extensions.dart';

import 'package:network_manager/auth/auth_manager.dart';
import 'package:network_manager/auth/i_auth_manager.dart';
import 'package:network_manager/client/i_network_client.dart';
import 'package:network_manager/client/network_client.dart';
import 'package:network_manager/configuration/config.dart';

/// A class to manage the initialisation of the [NetworkManager] module
class NetworkManager {
  // public keys for di
  static const networkClientKey = 'network_client';

  /// Registers all of the dependencies for the network manager's dependency
  /// injection system.
  static Future<void> registerDependencies({
    required IStorageService secureStorage,
    required String accessTokenKey,
    String? environment,
    Map<String, String>? header,
  }) async {
    // Read Network Configuration
    final config = await _readNetworkConfiguration(environment);

    ///we need refresh token for biometrics login
    ///secureStorage.delete('refresh_token');
    final authManager = AuthManager(
      secureStorage as SecureStorageService,
    );
    DIContainer.container.registerSingleton<IAuthManager>((container) => authManager);

    final networkClient = NetworkClient(
      authManager,
    );

    // register a network client and its dependencies
    DIContainer.container.registerSingleton<INetworkClient>(
      (c) => networkClient,
      name: networkClientKey,
    );

    await networkClient.initializeGraphQlClient(
      config: config,
      accessTokenKey: accessTokenKey,
      headers: header,
    );
  }

  static Future<Config> _readNetworkConfiguration(String? environment) async {
    var networkConfigFilePath = 'assets/configuration/network_configuration';

    if (environment?.isNotBlank() ?? false) {
      networkConfigFilePath = "${networkConfigFilePath}_${environment!}";
    }

    final networkConfigJson = await rootBundle.loadString('$networkConfigFilePath.json');
    final config = Config.fromJson(jsonDecode(networkConfigJson) as Map<String, dynamic>);
    print(config);
    return config;
  }
}
