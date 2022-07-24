import 'package:core/navigation/i_navigation_handler.dart';
import 'package:core/navigation/i_route_manager.dart';
import 'package:core/navigation/navigation_type.dart';
import 'package:flutter/material.dart';

class NavigationManager {
  static late INavigationHandler _navigationHandler;

  NavigationManager(INavigationHandler navigationHandler) {
    _navigationHandler = navigationHandler;
  }

  static void registerRouteManager(String featureName, IRouteManager routeManager) {
    _navigationHandler.registerRouteManager(featureName, routeManager);
  }

  static Route getRoute(RouteSettings settings) => _navigationHandler.getRoute(settings);

  static Future<dynamic> navigateTo(
    String routeName,
    NavigationType navigationType, {
    dynamic arguments,
    bool barrierDismissiable = true,
  }) async {
    return _navigationHandler.navigateTo(
      routeName,
      navigationType,
      arguments: arguments,
      barrierDismissiable: barrierDismissiable,
    );
  }

  static void goBack({arguments}) => _navigationHandler.goBack(arguments: arguments);

  static void popDialog({arguments}) => _navigationHandler.popDialog(arguments: arguments);

  static bool canPop(BuildContext context) => _navigationHandler.canPop(context);
}
