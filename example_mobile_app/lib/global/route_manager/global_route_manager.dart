import 'package:flutter/material.dart';

import 'package:core/navigation/i_route_manager.dart';
import 'package:example_mobile_app/features/landing/view/landing_view.dart';

part 'global_routes.dart';

class GlobalRouteManager extends IRouteManager {
  @override
  Widget getView(RouteSettings settings) {
    switch (settings.name) {
      case GlobalRoutes.landing:
        return const LandingView();

      default:
        throw Exception('Route ${settings.name} not found');
    }
  }
}
