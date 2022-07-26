import 'package:flutter/material.dart';

import 'package:overlay_support/overlay_support.dart';

import 'package:core/app/hex_material_app.dart';
import 'package:core/navigation/navigation_manager.dart';

class MyApp extends StatefulWidget {
  final Map<String, String> packages;
  final String appTitle;
  final Widget homeWidget;
  final ThemeData theme;

  const MyApp({
    Key? key,
    required this.appTitle,
    required this.packages,
    required this.homeWidget,
    required this.theme,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // allows the user to dismiss the keyboard by tapping away from any input.
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: OverlaySupport.global(
        child: HexMaterialApp(
          key: const Key('HexAppMaterialApp'),
          title: widget.appTitle,
          theme: widget.theme,
          home: widget.homeWidget,
          onGenerateRoute: NavigationManager.getRoute,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: Directionality(textDirection: TextDirection.ltr, child: child ?? Container()),
            );
          },
        ),
      ),
    );
  }
}
