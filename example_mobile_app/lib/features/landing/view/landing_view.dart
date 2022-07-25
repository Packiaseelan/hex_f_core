import 'package:core/base_classes/base_view.dart';
import 'package:example_mobile_app/features/landing/coordinator/landing_coordinator.dart';
import 'package:example_mobile_app/features/landing/view/widgets/landing_view_base_attribute.dart';
import 'package:example_mobile_app/features/landing/view/widgets/landing_view_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/hex_text/hex_text.dart';
import 'package:widget_library/scaffold/hex_scaffold.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LandingCoordinator, LandingState>(
      setupCoordinator: (coordinator) => coordinator.initialize(),
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, LandingState state, LandingCoordinator coordinator) {
    return HexScaffold(
      body: LandingViewBaseWidget(attribute: _createAttribute()),
    );
  }

  LandingViewBaseAttribute _createAttribute() {
    return LandingViewBaseAttribute(title: TextUIDataModel('title'));
  }
}
