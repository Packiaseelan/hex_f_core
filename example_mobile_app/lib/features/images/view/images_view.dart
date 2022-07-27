import 'package:core/base_classes/base_view.dart';
import 'package:example_mobile_app/features/images/coordinator/images_coordinator.dart';
import 'package:example_mobile_app/features/images/view/widgets/images_view_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/app_bar/hex_app_bar.dart';
import 'package:widget_library/hex_text/hex_text.dart';
import 'package:widget_library/image/hex_image_widget.dart';
import 'package:widget_library/scaffold/hex_scaffold.dart';
import 'package:widget_library/sub_title/sub_title_widget.dart';

class ImagesView extends StatelessWidget {
  const ImagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ImagesCoordinator, ImagesState>(
      setupCoordinator: (coordinator) => coordinator.initialize(),
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, ImagesState state, ImagesCoordinator coordinator) {
    return HexScaffold(
      appBarAttributes:
          HexAppBarAttributes(left: [HexAppBarButtonAttributes(type: HexAppBarButtons.back)], title: 'Images'),
      body: ImagesViewBaseWidget(
        attribute: _createAttribute(state),
      ),
    );
  }

  ImagesViewBaseAttribute _createAttribute(ImagesState state) {
    return ImagesViewBaseAttribute(
      iconTitle: SubTitleAttribute(
        title: TextUIDataModel(state.iconTitle, styleVariant: HexTextStyleVariant.headline4),
      ),
      icon: HexImageModel.asset(imagePath: state.iconPath),
      assetImageTitle: SubTitleAttribute(
        title: TextUIDataModel(state.imageTitle, styleVariant: HexTextStyleVariant.headline4),
      ),
      assetImage: HexImageModel.asset(imagePath: state.imagePath),
      networkImageTitle: SubTitleAttribute(
        title: TextUIDataModel(state.networkImageTitle, styleVariant: HexTextStyleVariant.headline4),
      ),
      networkImage: HexImageModel.network(imagePath: state.networkImagePath),
    );
  }
}
