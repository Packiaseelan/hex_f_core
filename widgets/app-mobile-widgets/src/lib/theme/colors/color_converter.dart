import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

///
/// Converts a JSON object into a TextStyle
///
class JsonColorConverter implements JsonConverter<Color, String> {
  const JsonColorConverter();

  @override
  Color fromJson(String json) {
    return Color(
      int.parse(json),
    );
  }

  @override
  String toJson(Color object) {
    // We probably don't need this as it's one-way conversion
    throw UnimplementedError();
  }
}
