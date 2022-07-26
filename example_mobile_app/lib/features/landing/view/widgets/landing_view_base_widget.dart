import 'package:flutter/material.dart';

import 'package:widget_library/hex_text/hex_text.dart';
import 'package:widget_library/image/hex_image_widget.dart';

import 'package:example_mobile_app/features/landing/view/widgets/landing_view_base_attribute.dart';

class LandingViewBaseWidget extends StatelessWidget {
  final LandingViewBaseAttribute attribute;

  const LandingViewBaseWidget({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HexImage(attribute.icon),
          HexText(text: attribute.title),
          HexImage(attribute.image),
          HexImage(attribute.networkImage),
        ],
      ),
    );
  }
}
