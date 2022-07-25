import 'package:example_mobile_app/features/landing/view/widgets/landing_view_base_attribute.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/hex_text/hex_text.dart';

class LandingViewBaseWidget extends StatelessWidget {
  final LandingViewBaseAttribute attribute;

  const LandingViewBaseWidget({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: HexText(text: attribute.title));
  }
}
