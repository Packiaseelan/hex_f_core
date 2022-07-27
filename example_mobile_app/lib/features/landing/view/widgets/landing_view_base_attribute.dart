import 'package:example_mobile_app/features/landing/coordinator/landing_coordinator.dart';

class LandingViewBaseAttribute {
  final List<Menu> menu;
  final Function(Menu) onPressed;

  LandingViewBaseAttribute({
    required this.menu,
    required this.onPressed,
  });
}
