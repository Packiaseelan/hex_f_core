part of 'hex_text.dart';

TextStyle buildTextStyle({
  required BuildContext context,
  required HexTextStyleVariant variant,
  HexTextVerticalSpacing? verticalSpacing,
  TextDecoration? decoration,
}) {
  switch (variant) {
    case HexTextStyleVariant.headline1:
      return _updateStyle(Theme.of(context).textTheme.headline1!, verticalSpacing, decoration);

    case HexTextStyleVariant.headline2:
      return _updateStyle(Theme.of(context).textTheme.headline2!, verticalSpacing, decoration);

    case HexTextStyleVariant.headline3:
      return _updateStyle(Theme.of(context).textTheme.headline3!, verticalSpacing, decoration);

    case HexTextStyleVariant.headline4:
      return _updateStyle(Theme.of(context).textTheme.headline4!, verticalSpacing, decoration);

    case HexTextStyleVariant.headline5:
      return _updateStyle(Theme.of(context).textTheme.headline5!, verticalSpacing, decoration);

    case HexTextStyleVariant.headline6:
      return _updateStyle(Theme.of(context).textTheme.headline6!, verticalSpacing, decoration);

    case HexTextStyleVariant.subtitle1:
      return _updateStyle(Theme.of(context).textTheme.subtitle1!, verticalSpacing, decoration);

    case HexTextStyleVariant.subtitle2:
      return _updateStyle(Theme.of(context).textTheme.subtitle2!, verticalSpacing, decoration);

    case HexTextStyleVariant.bodyText2:
      return _updateStyle(Theme.of(context).textTheme.bodyText2!, verticalSpacing, decoration);

    case HexTextStyleVariant.caption:
      return _updateStyle(Theme.of(context).textTheme.caption!, verticalSpacing, decoration);

    case HexTextStyleVariant.overline:
      return _updateStyle(Theme.of(context).textTheme.overline!, verticalSpacing, decoration);

    default:
      return _updateStyle(Theme.of(context).textTheme.bodyText1!, verticalSpacing, decoration);
  }
}

TextStyle _updateStyle(
  TextStyle style,
  HexTextVerticalSpacing? verticalSpacing,
  TextDecoration? decoration,
) {
  final lineHeight = _lineHeight(verticalSpacing);
  return style.copyWith(
    height: lineHeight,
    decoration: decoration,
    fontSize: style.fontSize?.sp,
  );
}

double _lineHeight(HexTextVerticalSpacing? verticalSpacing) {
  switch (verticalSpacing) {
    case HexTextVerticalSpacing.narrow:
      return 1.0;
    case HexTextVerticalSpacing.normal:
      return 1.2;
    default:
      return 1.2;
  }
}
