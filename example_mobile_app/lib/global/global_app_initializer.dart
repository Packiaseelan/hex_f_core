import 'package:flutter/material.dart';

import 'package:core/ioc/di_container.dart';
import 'package:core/navigation/navigation_manager.dart';
import 'package:core/storage/i_storage_service.dart';
import 'package:network_manager/network_manager.dart';
import 'package:shared_dependencies/shared_dependencies.dart';
import 'package:task_manager/task_manager_module.dart';
import 'package:widget_library/theme/hex_theme.dart';

import 'package:example_mobile_app/features/landing/coordinator/landing_coordinator.dart';
import 'package:example_mobile_app/features/splash/coordinator/splash_coordinator.dart';
import 'package:example_mobile_app/global/route_manager/global_route_manager.dart';

class GlobalAppInitializer {
  Future<ThemeData> appInitializer() async {
    final theme = HexTheme();
    await theme.initialize();

    NavigationManager.registerRouteManager(ModuleIdentifiers.global, GlobalRouteManager());


      final storageService = DIContainer.container.resolve<IStorageService>();

      TaskManagerModule.registerDependencies(
        secureStorageService: storageService,
      );

    _initializeFeatureModules();
    _initializeEnvironmentBasedDependencies();

    return Future.value(theme.defaultTheme);
  }

  void _initializeFeatureModules() {
    DIContainer.container.registerFactory(
      (container) => SplashCoordinator(
        SplashNavigationHandler(),
      ),
    );

    DIContainer.container.registerFactory(
      (container) => LandingCoordinator(),
    );
  }

  void _initializeEnvironmentBasedDependencies() async {
    final storageService = DIContainer.container.resolve<IStorageService>();
    await NetworkManager.registerDependencies(secureStorage: storageService, accessTokenKey: '');
  }
}
