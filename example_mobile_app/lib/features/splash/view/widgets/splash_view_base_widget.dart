import 'package:example_mobile_app/features/splash/view/widgets/splash_view_base_attribute.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/hex_text/hex_text.dart';

class SplashViewBaseWidget extends StatelessWidget {
  final SplashViewBaseAttribute attribute;

  const SplashViewBaseWidget({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: HexText(text: attribute.title),
    );
  }
}
