import 'package:flutter/material.dart';

import 'package:widget_library/hex_text/hex_text.dart';
import 'package:widget_library/image/hex_image_widget.dart';

class _Constants {
  static const borderRadius = 10.0;
  static const iconHorizontalSpacing = 4.0;
}

enum IconPosition { leading, trailing }

class IconTextButtonAttribute {
  final HexImageModel icon;
  final TextUIDataModel title;
  final Function onPressed;
  final IconPosition position;
  final EdgeInsets padding;
  final double borderRadius;

  IconTextButtonAttribute({
    required this.icon,
    required this.title,
    required this.onPressed,
    this.position = IconPosition.trailing,
    this.padding = EdgeInsets.zero,
    this.borderRadius = _Constants.borderRadius,
  });
}

class IconTextButtonWidget extends StatelessWidget {
  final IconTextButtonAttribute attribute;

  const IconTextButtonWidget({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(attribute.borderRadius),
      ),
      onPressed: () => attribute.onPressed(),
      child: Padding(
        padding: attribute.padding,
        child: Row(
          children: [
            if (attribute.position == IconPosition.leading) _buildIcon(),
            HexText(text: attribute.title),
            if (attribute.position == IconPosition.trailing) _buildIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      margin: EdgeInsets.only(
        left: attribute.position == IconPosition.trailing ? _Constants.iconHorizontalSpacing : 0,
        right: attribute.position == IconPosition.leading ? _Constants.iconHorizontalSpacing : 0,
      ),
      child: HexImage(attribute.icon),
    );
  }
}
