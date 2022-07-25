part of '../coordinator/splash_coordinator.dart';

abstract class ISplashNavigationHandler {
  void navigateToLanding();
}

class SplashNavigationHandler extends ISplashNavigationHandler {
  @override
  void navigateToLanding() {
    NavigationManager.navigateTo(_Constants.landingRoute, NavigationType.Replace);
  }
}
