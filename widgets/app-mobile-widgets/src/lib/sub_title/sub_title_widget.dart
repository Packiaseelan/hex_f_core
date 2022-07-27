import 'package:flutter/material.dart';
import 'package:widget_library/buttons/icon_text_button.dart';
import 'package:widget_library/hex_text/hex_text.dart';
import 'package:widget_library/image/hex_image_widget.dart';

class SubTitleAttribute {
  final HexImageModel? leadingIcon;
  final TextUIDataModel title;
  final TextUIDataModel? description;
  final IconTextButtonAttribute? action;
  final EdgeInsets padding;

  SubTitleAttribute({
    this.leadingIcon,
    required this.title,
    this.description,
    this.action,
    this.padding = EdgeInsets.zero,
  });
}

class SubTitleWidget extends StatelessWidget {
  final SubTitleAttribute attribute;

  const SubTitleWidget({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: attribute.padding,
      child: Row(
        children: [
          if (attribute.leadingIcon != null)
            SizedBox(
              width: 20,
              height: 20,
              child: HexImage(attribute.leadingIcon!),
            ),
          if (attribute.leadingIcon != null) const SizedBox(width: 6),
          Column(
            children: [
              HexText(text: attribute.title),
              if (attribute.description != null) HexText(text: attribute.description!),
            ],
          ),
          if (attribute.action != null) const Spacer(),
          if (attribute.action != null) IconTextButtonWidget(attribute: attribute.action!),
        ],
      ),
    );
  }
}
