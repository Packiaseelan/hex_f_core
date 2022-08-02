import 'package:flutter/material.dart';

import 'package:core/base_classes/base_view.dart';
import 'package:widget_library/hex_text/hex_text.dart';
import 'package:widget_library/scaffold/hex_scaffold.dart';

import 'package:example_mobile_app/features/splash/coordinator/splash_coordinator.dart';
import 'package:example_mobile_app/features/splash/view/widgets/splash_view_base_attribute.dart';
import 'package:example_mobile_app/features/splash/view/widgets/splash_view_base_widget.dart';

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
    return HexScaffold(
      builder: (context) => SplashViewBaseWidget(attribute: _createAttribute(state)),
    );
  }

  SplashViewBaseAttribute _createAttribute(SplashState state) {
    return SplashViewBaseAttribute(
      title: TextUIDataModel(state.title, styleVariant: HexTextStyleVariant.headline4),
    );
  }
}
