part of '../coordinator/landing_coordinator.dart';

abstract class ILandingNavigationHandler {
  void navigateTo(String routeName);
}

class LandingNavigationHandler extends ILandingNavigationHandler {
  @override
  void navigateTo(String routeName) {
    NavigationManager.navigateTo('${ModuleIdentifiers.global}-$routeName', NavigationType.Push);
  }
}
