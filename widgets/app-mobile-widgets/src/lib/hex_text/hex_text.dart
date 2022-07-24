import 'package:flutter/material.dart';

part 'hext_style_variant.dart';
part 'hex_text_vertical_spacing.dart';
part 'text_ui_data_model.dart';
part 'text_style.dart';

class HexText extends StatelessWidget {
  final TextUIDataModel text;
  final EdgeInsets padding;
  final HexTextVerticalSpacing? lineVerticalSpacing;

  const HexText({
    Key? key,
    required this.text,
    this.padding = EdgeInsets.zero,
    this.lineVerticalSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = buildTextStyle(
      context: context,
      variant: text.styleVariant ?? HexTextStyleVariant.normal,
      verticalSpacing: lineVerticalSpacing,
    );

    return Padding(
      padding: padding,
      child: Text(
        key: const Key('Hex_Text'),
        text.text,
        style: textStyle,
        overflow: text.overflow,
        textAlign: text.textAlign,
        maxLines: text.maxLines,
      ),
    );
  }
}
