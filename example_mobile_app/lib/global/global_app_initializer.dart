import 'package:flutter/material.dart';

import 'package:core/ioc/di_container.dart';
import 'package:core/navigation/navigation_manager.dart';
import 'package:shared_dependencies/shared_dependencies.dart';
import 'package:widget_library/theme/hex_theme.dart';

import 'package:example_mobile_app/features/landing/coordinator/landing_coordinator.dart';
import 'package:example_mobile_app/features/splash/coordinator/splash_coordinator.dart';
import 'package:example_mobile_app/global/route_manager/global_route_manager.dart';

class GlobalAppInitializer {
  Future<ThemeData> appInitializer() async {
    final theme = HexTheme();
    await theme.initialize();

    NavigationManager.registerRouteManager(ModuleIdentifiers.global, GlobalRouteManager());

    _initializeFeatureModules();

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
}
