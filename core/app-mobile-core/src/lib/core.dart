library core;

import 'dart:async';

import 'package:core/app/my_app.dart';
import 'package:core/inactivity_watcher/inactivity_watcher.dart';
import 'package:core/ioc/di_container.dart';
import 'package:core/navigation/i_navigation_handler.dart';
import 'package:core/navigation/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef AppInitializer = Future<ThemeData> Function();

class Core {
  Future<void> registerMinimalDependencies({
    required List<int> secretSalt,
    required INavigationHandler navigationHandler,
    required AppInitializer appInitializer,
    required Widget homeWidget,
    required String appTitle,
    required Map<String, String> packages,
  }) async {
    await runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        NavigationManager(navigationHandler);

        await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

        final theme = await appInitializer();

        _bootStrapTheApp(
          homeWidget: homeWidget,
          appTitle: appTitle,
          packages: packages,
          theme: theme,
        );
      },
      (error, stackTrace) {},
    );
  }

  void _bootStrapTheApp({
    required Widget homeWidget,
    required String appTitle,
    required Map<String, String> packages,
    required ThemeData theme,
    bool watchForInactivity = false,
  }) {
    Widget myApp = MyApp(
      appTitle: appTitle,
      packages: packages,
      homeWidget: homeWidget,
      theme: theme,
    );

    if (watchForInactivity) {
      myApp = InactivityWatcher(
        inactivityService: DIContainer.container.resolve(),
        child: myApp,
      );
    }

    runApp(
      ProviderScope(
        key: const Key('ProviderScope'),
        child: myApp,
      ),
    );
  }
}
