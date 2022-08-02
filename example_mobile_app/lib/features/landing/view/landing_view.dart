import 'package:flutter/material.dart';

import 'package:core/base_classes/base_view.dart';

import 'package:widget_library/scaffold/hex_scaffold.dart';

import 'package:example_mobile_app/features/landing/coordinator/landing_coordinator.dart';
import 'package:example_mobile_app/features/landing/view/widgets/landing_view_base_attribute.dart';
import 'package:example_mobile_app/features/landing/view/widgets/landing_view_base_widget.dart';

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
      appBarBuilder: (context) => _appBarBuilder(context, state),
      builder: (context) => LandingViewBaseWidget(
        attribute: _createAttribute(state, coordinator),
      ),
    );
  }

  // Custom Appbar
  PreferredSizeWidget? _appBarBuilder(BuildContext context, LandingState state) {
    return AppBar(
      title: Text(state.pageTitle),
    );
  }

  LandingViewBaseAttribute _createAttribute(LandingState state, LandingCoordinator coordinator) {
    return LandingViewBaseAttribute(
      menu: state.menu,
      onPressed: coordinator.navigateTo,
    );
  }
}
