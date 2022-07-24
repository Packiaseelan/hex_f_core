part of 'hex_text.dart';

class TextUIDataModel {
  final String text;
  final HexTextStyleVariant? styleVariant;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxLines;

  TextUIDataModel(this.text, this.styleVariant, this.overflow, this.textAlign, this.maxLines);
}
