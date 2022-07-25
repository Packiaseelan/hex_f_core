import 'package:core/base_classes/base_coordinator.dart';

part '../state/landing_state.dart';

class LandingCoordinator extends BaseCoordinator<LandingState> {
  LandingCoordinator() : super(LandingState());

  void initialize() {}
}
