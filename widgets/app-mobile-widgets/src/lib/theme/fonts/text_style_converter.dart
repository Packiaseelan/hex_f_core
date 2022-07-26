import 'package:flutter/widgets.dart';

import 'package:json_annotation/json_annotation.dart';

// Supported properties
String _fontFamily = 'fontFamily';
String _fontSize = 'fontSize';
String _fontWeight = 'fontWeight';
String _fontStyle = 'fontStyle';
String _letterSpacing = 'letterSpacing';
String _wordSpacing = 'wordSpacing';
String _height = 'height';

///
/// Converts a JSON object into a TextStyle
///
class JsonTextStyleConverter implements JsonConverter<TextStyle, Map<String, dynamic>> {
  const JsonTextStyleConverter();

  @override
  TextStyle fromJson(Map<String, dynamic> json) {
    return TextStyle(
      fontFamily: json[_fontFamily] as String?,
      fontSize: json[_fontSize] as double?,
      fontWeight: _parseFontWeight(json[_fontWeight] as String?),
      fontStyle: _parseFontStyle(json[_fontStyle] as String?),
      letterSpacing: json[_letterSpacing] as double?,
      wordSpacing: json[_wordSpacing] as double?,
      height: json[_height] as double?,
    );
  }

  @override
  Map<String, dynamic> toJson(TextStyle object) {
    // We probably don't need this as it's one-way conversion
    throw UnimplementedError();
  }

  FontWeight _parseFontWeight(String? fontWeight) => FontWeight.values.firstWhere(
        (element) => element.toString() == 'FontWeight.w$fontWeight',
        orElse: () => FontWeight.normal,
      );

  FontStyle _parseFontStyle(String? fontStyle) => FontStyle.values.firstWhere(
        (element) => element.toString() == 'FontStyle.$fontStyle',
        orElse: () => FontStyle.normal,
      );
}
