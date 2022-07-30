import 'dart:convert';

import 'package:core/logging/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:json_annotation/json_annotation.dart';
import 'package:core/utils/extensions/string_extensions.dart';

part 'hex_theme.g.dart';

@JsonSerializable()
class HexColorPalette {
  String? primary;
  String? secondary;
  String? tertiary;
  String? quaternary;
  String? quinary;
  String? senary;
  String? septenary;
  String? octonary;
  String? nonary;
  String? denary;
  String? infoIcon;
  String? panelColorPrimary;
  String? panelColorSecondary;
  String? panelColorTertiary;

  HexColorPalette({
    this.primary,
    this.secondary,
    this.tertiary,
    this.quaternary,
    this.quinary,
    this.senary,
    this.septenary,
    this.octonary,
    this.nonary,
    this.denary,
    this.infoIcon,
    this.panelColorPrimary,
    this.panelColorSecondary,
    this.panelColorTertiary,
  });

  factory HexColorPalette.fromJson(Map<String, dynamic> json) => _$HexColorPaletteFromJson(json);
  Map<String, dynamic> toJson() => _$HexColorPaletteToJson(this);
}

@JsonSerializable()
class HexSliderThemeData {
  String? activeTrackColor;
  String? inactiveTrackColor;

  HexSliderThemeData({
    this.activeTrackColor,
    this.inactiveTrackColor,
  });

  factory HexSliderThemeData.fromJson(Map<String, dynamic> json) => _$HexSliderThemeDataFromJson(json);
  Map<String, dynamic> toJson() => _$HexSliderThemeDataToJson(this);
}

@JsonSerializable()
class HexCardThemeData {
  final String? color;
  final String? shadowColor;
  final double? elevation;
  HexCardThemeData({
    this.color,
    this.shadowColor,
    this.elevation,
  });

  factory HexCardThemeData.fromJson(Map<String, dynamic> json) => _$HexCardThemeDataFromJson(json);
  Map<String, dynamic> toJson() => _$HexCardThemeDataToJson(this);
}

@JsonSerializable()
class HexAppBarThemeData {
  String? foregroundColor;
  String? backgroundColor;
  HexStyleData? iconTheme;
  HexStyleData? actionIconsTheme;
  HexStyleData? titleTextStyle;

  @JsonKey(name: 'textTheme')
  HexTextThemeData? textThemeData;

  HexAppBarThemeData({
    this.foregroundColor,
    this.backgroundColor,
    this.iconTheme,
    this.actionIconsTheme,
    this.titleTextStyle,
    this.textThemeData,
  });

  factory HexAppBarThemeData.fromJson(Map<String, dynamic> json) => _$HexAppBarThemeDataFromJson(json);
  Map<String, dynamic> toJson() => _$HexAppBarThemeDataToJson(this);
}

@JsonSerializable()
class HexStyleData {
  String? color;
  String? fontFamily;
  double? fontSize;
  double? opacity;
  String? textColor;
  double? minimumSize;
  double? borderRadius;
  int? fontWeight;
  double? letterSpacing;

  HexStyleData({
    this.color,
    this.fontFamily,
    this.fontSize,
    this.opacity,
    this.textColor,
    this.minimumSize,
    this.borderRadius,
    this.fontWeight,
    this.letterSpacing,
  });

  factory HexStyleData.fromJson(Map<String, dynamic> json) => _$HexStyleDataFromJson(json);
  Map<String, dynamic> toJson() => _$HexStyleDataToJson(this);
}

@JsonSerializable()
class HexTextThemeData {
  HexStyleData? headline1;
  HexStyleData? headline2;
  HexStyleData? headline3;
  HexStyleData? headline4;
  HexStyleData? headline5;
  HexStyleData? headline6;
  HexStyleData? subtitle1;
  HexStyleData? subtitle2;
  HexStyleData? bodyText1;
  HexStyleData? bodyText2;
  HexStyleData? caption;
  HexStyleData? overline;

  HexTextThemeData({
    this.headline1,
    this.headline2,
    this.headline3,
    this.headline4,
    this.headline5,
    this.headline6,
    this.subtitle1,
    this.subtitle2,
    this.bodyText1,
    this.bodyText2,
    this.caption,
    this.overline,
  });

  factory HexTextThemeData.fromJson(Map<String, dynamic> json) => _$HexTextThemeDataFromJson(json);
  Map<String, dynamic> toJson() => _$HexTextThemeDataToJson(this);
}

@JsonSerializable()
class HexInputDecorationThemeData {
  HexStyleData? hintStyle;
  HexStyleData? errorStyle;
  HexStyleData? labelStyle;

  HexInputDecorationThemeData({
    this.hintStyle,
    this.errorStyle,
    this.labelStyle,
  });

  factory HexInputDecorationThemeData.fromJson(Map<String, dynamic> json) =>
      _$HexInputDecorationThemeDataFromJson(json);
  Map<String, dynamic> toJson() => _$HexInputDecorationThemeDataToJson(this);
}

@JsonSerializable()
class HexScreenThemeData {
  String screenName;
  String? highlightTextColor;
  String? actionButtonIconColor;
  String? textFieldBackgroundColor;
  String? primaryColor;
  String? primaryColorDark;
  String? primaryColorLight;
  String? splashColor;
  String? scaffoldBackgroundColor;
  String? backgroundColor;
  String? errorColor;
  String? bottomAppBarColor;
  String? toggleableActiveColor;
  String? dividerColor;
  String? shadowColor;
  String? midNightTint;
  HexStyleData? iconTheme;
  HexAppBarThemeData? appBarTheme;
  HexCardThemeData? cardTheme;
  HexTextThemeData? textTheme;
  HexStyleData? elevatedButtonTheme;
  HexStyleData? textButtonTheme;
  HexStyleData? textSelectionTheme;
  HexInputDecorationThemeData? inputDecorationTheme;
  HexStyleData? checkboxThemeData;
  HexStyleData? segmentedThemeData;
  HexSliderThemeData? sliderTheme;

  HexScreenThemeData({
    required this.screenName,
    this.primaryColor,
    this.primaryColorDark,
    this.primaryColorLight,
    this.splashColor,
    this.scaffoldBackgroundColor,
    this.backgroundColor,
    this.errorColor,
    this.bottomAppBarColor,
    this.toggleableActiveColor,
    this.dividerColor,
    this.highlightTextColor,
    this.textFieldBackgroundColor,
    this.actionButtonIconColor,
    this.iconTheme,
    this.appBarTheme,
    this.cardTheme,
    this.textTheme,
    this.elevatedButtonTheme,
    this.textButtonTheme,
    this.textSelectionTheme,
    this.inputDecorationTheme,
    this.checkboxThemeData,
    this.segmentedThemeData,
    this.sliderTheme,
    this.shadowColor,
    this.midNightTint,
  });

  factory HexScreenThemeData.fromJson(Map<String, dynamic> json) => _$HexScreenThemeDataFromJson(json);
  Map<String, dynamic> toJson() => _$HexScreenThemeDataToJson(this);
}

@JsonSerializable()
class HexThemeData {
  @JsonKey(name: 'colors')
  HexColorPalette? colorPalette;

  List<HexScreenThemeData> screens;

  HexThemeData({
    this.colorPalette,
    required this.screens,
  });

  factory HexThemeData.fromJson(Map<String, dynamic> json) => _$HexThemeDataFromJson(json);
  Map<String, dynamic> toJson() => _$HexThemeDataToJson(this);
}

class HexTheme {
  ThemeData? defaultTheme;
  // late ThemeData currentTheme;

  late HexThemeData themeData;
  late HexScreenThemeData defaultThemeData;

  static final HexTheme _singleton = HexTheme._internal();

  factory HexTheme() {
    return _singleton;
  }

  HexTheme._internal();

  TextStyle? _buildTextStyle(HexStyleData? styleData) {
    if (styleData != null) {
      var fontWeightIndex = 3; // default font weight index
      if (styleData.fontWeight != null && styleData.fontWeight! >= 0 && styleData.fontWeight! <= 8) {
        fontWeightIndex = styleData.fontWeight!;
      }
      return TextStyle(
        color: styleData.color?.toColorWithOpacity(styleData.opacity ?? 1.0),
        fontFamily: styleData.fontFamily,
        fontSize: styleData.fontSize,
        fontWeight: FontWeight.values[fontWeightIndex],
        letterSpacing: styleData.letterSpacing,
      );
    }

    return null;
  }

  TextStyle? _buildTextStyleForButton(HexStyleData? styleData) {
    if (styleData != null) {
      var fontWeightIndex = 3; // default font weight index
      if (styleData.fontWeight != null && styleData.fontWeight! >= 0 && styleData.fontWeight! <= 8) {
        fontWeightIndex = styleData.fontWeight!;
      }
      return TextStyle(
        color: styleData.textColor?.toColorWithOpacity(styleData.opacity ?? 1.0),
        fontFamily: styleData.fontFamily,
        fontSize: styleData.fontSize,
        fontWeight: FontWeight.values[fontWeightIndex],
      );
    }

    return null;
  }

  Future<void> initialize() async {
    final serialisedJson = await rootBundle.loadString(
      'assets/styles/theme_data.json',
    );

    // Pull out the themes object and iterate over the themes
    final json = jsonDecode(serialisedJson) as Map<String, dynamic>;
    themeData = HexThemeData.fromJson(json);

    defaultTheme = _buildTheme(
      'default',
    );

    try {
      defaultThemeData =
          themeData.screens.firstWhere((element) => element.screenName.toLowerCase().compareTo('default') == 0);
    } on StateError catch (error) {
      HexLogger.logDebug(error.message);
    }
  }

  ElevatedButtonThemeData _buildElevatedButtonTheme(HexStyleData? elevatedButtonTheme) {
    var style = ElevatedButton.styleFrom(
      primary: elevatedButtonTheme?.color?.toColor(),
      onPrimary: elevatedButtonTheme?.textColor?.toColor(),
      textStyle: _buildTextStyleForButton(elevatedButtonTheme),
      minimumSize:
          (elevatedButtonTheme?.minimumSize != null) ? Size.fromHeight(elevatedButtonTheme!.minimumSize!) : null,
      shape: (elevatedButtonTheme?.borderRadius != null)
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(elevatedButtonTheme!.borderRadius!),
            )
          : null,
    );
    return ElevatedButtonThemeData(
      style: style,
    );
  }

  TextTheme _buildTextTheme(
    HexTextThemeData? textTheme, {
    TextTheme? defaulTextTheme,
  }) {
    return TextTheme(
      headline1: (textTheme?.headline1 != null) ? _buildTextStyle(textTheme?.headline1) : defaulTextTheme?.headline1,
      headline2: (textTheme?.headline2 != null) ? _buildTextStyle(textTheme?.headline2) : defaulTextTheme?.headline2,
      headline3: (textTheme?.headline3 != null) ? _buildTextStyle(textTheme?.headline3) : defaulTextTheme?.headline3,
      headline4: (textTheme?.headline4 != null) ? _buildTextStyle(textTheme?.headline4) : defaulTextTheme?.headline4,
      headline5: (textTheme?.headline5 != null) ? _buildTextStyle(textTheme?.headline5) : defaulTextTheme?.headline5,
      headline6:
          (textTheme?.headline6 != null) ? _buildTextStyle(textTheme?.headline6) : defaultTheme?.textTheme.headline6,
      subtitle1:
          (textTheme?.subtitle1 != null) ? _buildTextStyle(textTheme?.subtitle1) : defaultTheme?.textTheme.subtitle1,
      subtitle2:
          (textTheme?.subtitle2 != null) ? _buildTextStyle(textTheme?.subtitle2) : defaultTheme?.textTheme.subtitle2,
      bodyText1:
          (textTheme?.bodyText1 != null) ? _buildTextStyle(textTheme?.bodyText1) : defaultTheme?.textTheme.bodyText1,
      bodyText2:
          (textTheme?.bodyText2 != null) ? _buildTextStyle(textTheme?.bodyText2) : defaultTheme?.textTheme.bodyText2,
      caption: (textTheme?.caption != null) ? _buildTextStyle(textTheme?.caption) : defaultTheme?.textTheme.caption,
    );
  }

  SliderThemeData? _buildSliderTheme(
    HexSliderThemeData? slideThemeData,
    SliderThemeData? defaultSlideThemeData,
  ) {
    final slider = slideThemeData != null
        ? SliderThemeData(
            activeTrackColor: slideThemeData.activeTrackColor.toColor(),
            inactiveTrackColor: slideThemeData.inactiveTrackColor.toColor(),
          )
        : defaultSlideThemeData;

    return slider;
  }

  ThemeData _buildTheme(
    String? screenName, {
    ThemeData? defaultThemeData,
  }) {
    if (screenName.isBlank()) {
      return defaultThemeData!;
    }
    HexScreenThemeData? screenThemeData;
    try {
      screenThemeData = themeData.screens
          .firstWhere((element) => element.screenName.toLowerCase().compareTo(screenName!.toLowerCase()) == 0);
    } on StateError catch (error) {
      HexLogger.logDebug(error.message);
    }

    return ThemeData(
      primaryColor: screenThemeData?.primaryColor?.toColor() ?? defaultThemeData?.primaryColor,
      primaryColorDark: screenThemeData?.primaryColorDark?.toColor() ?? defaultThemeData?.primaryColorDark,
      primaryColorLight: screenThemeData?.primaryColorLight?.toColor() ?? defaultThemeData?.primaryColorLight,
      splashColor: screenThemeData?.splashColor?.toColor() ?? defaultThemeData?.splashColor,
      scaffoldBackgroundColor:
          screenThemeData?.scaffoldBackgroundColor?.toColor() ?? defaultThemeData?.scaffoldBackgroundColor,
      backgroundColor: screenThemeData?.backgroundColor?.toColor() ?? defaultThemeData?.backgroundColor,
      errorColor: screenThemeData?.errorColor?.toColor() ?? defaultThemeData?.errorColor,
      bottomAppBarColor: screenThemeData?.bottomAppBarColor?.toColor() ?? defaultThemeData?.bottomAppBarColor,
      toggleableActiveColor:
          screenThemeData?.toggleableActiveColor?.toColor() ?? defaultThemeData?.toggleableActiveColor,
      dividerColor: screenThemeData?.dividerColor?.toColor() ?? defaultThemeData?.dividerColor,
      sliderTheme: _buildSliderTheme(
        screenThemeData?.sliderTheme,
        defaultThemeData?.sliderTheme,
      ),
      iconTheme: IconThemeData(
        color: screenThemeData?.iconTheme?.color?.toColor() ?? defaultThemeData?.iconTheme.color,
        size: screenThemeData?.iconTheme?.minimumSize ?? defaultThemeData?.iconTheme.size,
      ),
      appBarTheme: AppBarTheme(
        foregroundColor:
            screenThemeData?.appBarTheme?.foregroundColor?.toColor() ?? defaultThemeData?.appBarTheme.foregroundColor,
        backgroundColor:
            screenThemeData?.appBarTheme?.backgroundColor?.toColor() ?? defaultThemeData?.appBarTheme.backgroundColor,
        iconTheme: IconThemeData(
          color: screenThemeData?.appBarTheme?.iconTheme?.color?.toColor() ??
              defaultThemeData?.appBarTheme.iconTheme?.color,
          size: screenThemeData?.appBarTheme?.iconTheme?.minimumSize ?? defaultThemeData?.appBarTheme.iconTheme?.size,
        ),
        actionsIconTheme: (screenThemeData?.appBarTheme?.actionIconsTheme != null)
            ? IconThemeData(color: screenThemeData?.appBarTheme?.actionIconsTheme?.color?.toColor())
            : defaultTheme?.appBarTheme.actionsIconTheme,
        titleTextStyle: _buildTextStyle(screenThemeData?.appBarTheme?.titleTextStyle) ??
            defaultThemeData?.appBarTheme.titleTextStyle,
        toolbarTextStyle: _buildTextTheme(
          screenThemeData?.appBarTheme?.textThemeData,
        ).bodyText1,
      ),
      cardTheme: CardTheme(
        color: screenThemeData?.cardTheme?.color?.toColor() ?? defaultThemeData?.cardTheme.color,
        shadowColor: screenThemeData?.cardTheme?.shadowColor?.toColor() ?? defaultThemeData?.cardTheme.shadowColor,
        elevation: screenThemeData?.cardTheme?.elevation ?? defaultThemeData?.cardTheme.elevation,
      ),
      textTheme: _buildTextTheme(
        screenThemeData?.textTheme,
        defaulTextTheme: defaultTheme?.textTheme,
      ),
      elevatedButtonTheme: (screenThemeData?.elevatedButtonTheme != null)
          ? _buildElevatedButtonTheme(
              screenThemeData?.elevatedButtonTheme,
            )
          : defaultThemeData?.elevatedButtonTheme,
      textButtonTheme: (screenThemeData?.textButtonTheme != null)
          ? TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: screenThemeData?.textButtonTheme?.color?.toColor(),
                textStyle: _buildTextStyle(screenThemeData?.textButtonTheme),
              ),
            )
          : defaultThemeData?.textButtonTheme,
      textSelectionTheme: (screenThemeData?.textSelectionTheme != null)
          ? TextSelectionThemeData(
              cursorColor: screenThemeData?.textSelectionTheme?.color?.toColor(),
            )
          : defaultThemeData?.textSelectionTheme,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: (screenThemeData?.inputDecorationTheme?.hintStyle != null)
            ? _buildTextStyle(
                screenThemeData?.inputDecorationTheme?.hintStyle,
              )
            : defaultThemeData?.inputDecorationTheme.hintStyle,
        errorStyle: (screenThemeData?.inputDecorationTheme?.errorStyle != null)
            ? _buildTextStyle(
                screenThemeData?.inputDecorationTheme?.errorStyle,
              )
            : defaultThemeData?.inputDecorationTheme.errorStyle,
        labelStyle: (screenThemeData?.inputDecorationTheme?.labelStyle != null)
            ? _buildTextStyle(
                screenThemeData?.inputDecorationTheme?.labelStyle,
              )
            : defaultThemeData?.inputDecorationTheme.labelStyle,
      ),
      checkboxTheme: (screenThemeData?.checkboxThemeData != null)
          ? CheckboxThemeData(
              checkColor: _CheckBoxThemeData(
                selected: screenThemeData?.checkboxThemeData!.textColor.toColor(),
                disabled: screenThemeData?.checkboxThemeData!.color.toColor(),
              ),
            )
          : defaultTheme?.checkboxTheme,
      shadowColor: screenThemeData?.shadowColor?.toColor(),
    );
  }

  ThemeData themeFor(String? screenName) {
    if (screenName.isBlank()) {
      return defaultTheme!;
    } else {
      return _buildTheme(
        screenName,
        defaultThemeData: defaultTheme,
      );
    }
  }
}

@immutable
class _CheckBoxThemeData extends MaterialStateProperty<Color?> with Diagnosticable {
  _CheckBoxThemeData({
    this.selected,
    this.disabled,
  });

  final Color? selected;
  final Color? disabled;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return selected;
    }

    return disabled;
  }
}
