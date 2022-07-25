import 'dart:async';

import 'package:core/base_classes/base_coordinator.dart';
import 'package:core/navigation/navigation_manager.dart';
import 'package:example_mobile_app/global/route_manager/global_route_manager.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

part '../state/splash_state.dart';
part '../navigation_handler/splash_navigation_handler.dart';

class _Constants {
  static const landingRoute = '${ModuleIdentifiers.global}-${GlobalRoutes.landing}';

  static const splashDuration = 2;
}

class SplashCoordinator extends BaseCoordinator<SplashState> {
  final ISplashNavigationHandler _navigationHandler;

  SplashCoordinator(this._navigationHandler) : super(SplashState());

  void initialize() {
    Timer(const Duration(seconds: _Constants.splashDuration), _navigateToLanding);
  }

  void _navigateToLanding() => _navigationHandler.navigateToLanding();
}
