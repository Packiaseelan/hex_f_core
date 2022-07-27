import 'package:flutter/material.dart';
import 'package:widget_library/hex_text/hex_text.dart';
import 'package:widget_library/image/hex_image_widget.dart';
import 'package:widget_library/sub_title/sub_title_widget.dart';

class ImagesViewBaseAttribute {
  final SubTitleAttribute iconTitle;
  final HexImageModel icon;
  final SubTitleAttribute assetImageTitle;
  final HexImageModel assetImage;
  final SubTitleAttribute networkImageTitle;
  final HexImageModel networkImage;

  ImagesViewBaseAttribute({
    required this.iconTitle,
    required this.icon,
    required this.assetImageTitle,
    required this.assetImage,
    required this.networkImageTitle,
    required this.networkImage,
  });
}

class ImagesViewBaseWidget extends StatelessWidget {
  final ImagesViewBaseAttribute attribute;

  const ImagesViewBaseWidget({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        child: Column(
          children: [
            SubTitleWidget(attribute: attribute.iconTitle),
            HexImage(attribute.icon),
            SubTitleWidget(attribute: attribute.assetImageTitle),
            HexImage(attribute.assetImage),
            SubTitleWidget(attribute: attribute.networkImageTitle),
            HexImage(attribute.networkImage),
            HexText(text: TextUIDataModel('Headline 1', styleVariant: HexTextStyleVariant.headline1)),
            HexText(text: TextUIDataModel('Headline 2', styleVariant: HexTextStyleVariant.headline2)),
            HexText(text: TextUIDataModel('Headline 3', styleVariant: HexTextStyleVariant.headline3)),
            HexText(text: TextUIDataModel('Headline 4', styleVariant: HexTextStyleVariant.headline4)),
            HexText(text: TextUIDataModel('Headline 5', styleVariant: HexTextStyleVariant.headline5)),
            HexText(text: TextUIDataModel('Headline 6', styleVariant: HexTextStyleVariant.headline6)),
          ],
        ),
      ),
    );
  }
}
