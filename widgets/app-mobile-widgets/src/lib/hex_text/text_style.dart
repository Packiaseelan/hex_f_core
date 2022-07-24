part of 'hex_text.dart';

TextStyle buildTextStyle({
  required BuildContext context,
  required HexTextStyleVariant variant,
  HexTextVerticalSpacing? verticalSpacing,
}) {
  final lineHeight = _lineHeight(verticalSpacing);

  switch (variant) {
    case HexTextStyleVariant.headline1:
      return Theme.of(context).textTheme.headline1!.copyWith(height: lineHeight);

    case HexTextStyleVariant.headline2:
      return Theme.of(context).textTheme.headline2!.copyWith(height: lineHeight);

    case HexTextStyleVariant.headline3:
      return Theme.of(context).textTheme.headline3!.copyWith(height: lineHeight);

    case HexTextStyleVariant.headline4:
      return Theme.of(context).textTheme.headline4!.copyWith(height: lineHeight);

    case HexTextStyleVariant.headline5:
      return Theme.of(context).textTheme.headline5!.copyWith(height: lineHeight);

    case HexTextStyleVariant.headline6:
      return Theme.of(context).textTheme.headline6!.copyWith(height: lineHeight);

    case HexTextStyleVariant.subtitle1:
      return Theme.of(context).textTheme.subtitle1!.copyWith(height: lineHeight);

    case HexTextStyleVariant.subtitle2:
      return Theme.of(context).textTheme.subtitle2!.copyWith(height: lineHeight);

    case HexTextStyleVariant.bodyText2:
      return Theme.of(context).textTheme.bodyText2!.copyWith(height: lineHeight);

    case HexTextStyleVariant.caption:
      return Theme.of(context).textTheme.caption!.copyWith(height: lineHeight);

    default:
      return Theme.of(context).textTheme.bodyText1!.copyWith(height: lineHeight);
  }
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
