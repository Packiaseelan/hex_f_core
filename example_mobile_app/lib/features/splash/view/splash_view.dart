import 'package:core/base_classes/base_view.dart';
import 'package:example_mobile_app/features/splash/coordinator/splash_coordinator.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashCoordinator, SplashState>(
      setupCoordinator: (coordinator) => coordinator.initialize(),
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, SplashState state, SplashCoordinator coordinator) {
    return Container();
  }
}
