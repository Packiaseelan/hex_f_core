import 'package:flutter/material.dart';
import 'package:get/get_core/src/log.dart';
import 'package:get/get_core/src/smart_management.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:get/get_navigation/src/routes/custom_transition.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/observers/route_observer.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class HexMaterialApp extends GetMaterialApp {
  HexMaterialApp({
    GlobalKey<NavigatorState>? navigatorKey,
    Key? key,
    Widget? home,
    Map<String, WidgetBuilder>? routes,
    String? initialRoute,
    RouteFactory? onGenerateRoute,
    InitialRouteListFactory? onGenerateInitialRoutes,
    RouteFactory? onUnknownRoute,
    List<NavigatorObserver>? navigatorObservers,
    TransitionBuilder? builder,
    String title = '',
    GenerateAppTitle? onGenerateTitle,
    ThemeData? theme,
    ThemeData? darkTheme,
    ThemeMode themeMode = ThemeMode.system,
    CustomTransition? customTransition,
    Color? color,
    Map<String, Map<String, String>>? translationsKeys,
    Translations? translations,
    TextDirection? textDirection,
    bool showPerformanceOverlay = false,
    bool checkerboardRasterCacheImages = false,
    bool checkerboardOffscreenLayers = false,
    bool showSemanticsDebugger = false,
    bool debugShowCheckedModeBanner = true,
    Map<LogicalKeySet, Intent>? shortcuts,
    ThemeData? highContrastTheme,
    ThemeData? highContrastDarkTheme,
    Map<Type, Action<Intent>>? actions,
    bool debugShowMaterialGrid = false,
    ValueChanged<Routing?>? routingCallback,
    Transition? defaultTransition,
    bool? opaqueRoute,
    VoidCallback? onInit,
    VoidCallback? onReady,
    VoidCallback? onDispose,
    bool? enableLog,
    LogWriterCallback? logWriterCallback,
    bool? popGesture,
    SmartManagement smartManagement = SmartManagement.full,
    Bindings? initialBinding,
    Duration? transitionDuration,
    bool? defaultGlobalState,
    List<GetPage>? getPages,
    GetPage? unknownRoute,
    RouteInformationProvider? routeInformationProvider,
    RouteInformationParser<Object>? routeInformationParser,
    RouterDelegate<Object>? routerDelegate,
    BackButtonDispatcher? backButtonDispatcher,
    List<NavigatorObserver> navigationObservers = const <NavigatorObserver>[],
  }) : super(
          color: color,
          builder: builder,
          theme: theme,
          title: title,
          key: key,
          actions: actions,
          checkerboardOffscreenLayers: checkerboardOffscreenLayers,
          checkerboardRasterCacheImages: checkerboardRasterCacheImages,
          customTransition: customTransition,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: debugShowCheckedModeBanner,
          debugShowMaterialGrid: debugShowMaterialGrid,
          defaultGlobalState: defaultGlobalState,
          defaultTransition: defaultTransition,
          enableLog: enableLog,
          getPages: getPages,
          highContrastDarkTheme: highContrastDarkTheme,
          highContrastTheme: highContrastTheme,
          home: home,
          initialBinding: initialBinding,
          initialRoute: initialRoute,
          logWriterCallback: logWriterCallback,
          navigatorKey: navigatorKey,
          navigatorObservers: navigationObservers,
          onDispose: onDispose,
          onGenerateInitialRoutes: onGenerateInitialRoutes,
          onGenerateRoute: onGenerateRoute,
          onGenerateTitle: onGenerateTitle,
          onInit: onInit,
          onReady: onReady,
          onUnknownRoute: onUnknownRoute,
          opaqueRoute: opaqueRoute,
          popGesture: popGesture,
          routes: routes = const <String, WidgetBuilder>{},
          routingCallback: routingCallback,
          shortcuts: shortcuts,
          showPerformanceOverlay: showPerformanceOverlay,
          showSemanticsDebugger: showSemanticsDebugger,
          smartManagement: smartManagement,
          textDirection: textDirection,
          themeMode: themeMode,
          transitionDuration: transitionDuration,
          translations: translations,
          translationsKeys: translationsKeys,
          unknownRoute: unknownRoute,
        );
}