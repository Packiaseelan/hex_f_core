import 'package:example_mobile_app/features/landing/view/widgets/categories_widget.dart';
import 'package:flutter/material.dart';

import 'package:core/base_classes/base_view.dart';

import 'package:widget_library/app_bar/hex_app_bar.dart';
import 'package:widget_library/buttons/icon_text_button.dart';
import 'package:widget_library/hex_text/hex_text.dart';
import 'package:widget_library/image/hex_image_widget.dart';
import 'package:widget_library/scaffold/hex_scaffold.dart';

import 'package:example_mobile_app/features/landing/coordinator/landing_coordinator.dart';
import 'package:example_mobile_app/features/landing/view/widgets/landing_view_base_attribute.dart';
import 'package:example_mobile_app/features/landing/view/widgets/landing_view_base_widget.dart';
import 'package:widget_library/sub_title/sub_title_widget.dart';

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
      // appBarAttributes: _createAppBar(state),
      appBarBuilder: (context) => _appBarBuilder(context, state),
      body: LandingViewBaseWidget(attribute: _createAttribute(state)),
    );
  }

  // Default Appbar with customizable buttons
  HexAppBarAttributes _createAppBar(LandingState state) {
    return HexAppBarAttributes(left: [
      HexAppBarButtonAttributes(type: HexAppBarButtons.menu),
    ], right: [
      HexAppBarButtonAttributes(type: HexAppBarButtons.info),
      HexAppBarButtonAttributes(type: HexAppBarButtons.more),
    ], title: state.pageTitle);
  }

  // Custom Appbar
  PreferredSizeWidget? _appBarBuilder(BuildContext context, LandingState state) {
    return AppBar(
      title: Text(state.pageTitle),
    );
  }

  LandingViewBaseAttribute _createAttribute(LandingState state) {
    return LandingViewBaseAttribute(
      title: TextUIDataModel('title'),
      icon: HexImageModel(imagePath: state.iconPath),
      image: HexImageModel(imagePath: state.bgImage),
      networkImage: HexImageModel.network(imagePath: state.networkImage),
      nos: state.nos,
      categories: CategoriesAttribute(
        title: SubTitleAttribute(
          title: TextUIDataModel('Categories'),
          leadingIcon: HexImageModel.asset(imagePath: 'assets/icons/bag.svg'),
          action: IconTextButtonAttribute(
            title: TextUIDataModel('See All'),
            icon: HexImageModel.asset(imagePath: 'assets/icons/bag.svg'),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
