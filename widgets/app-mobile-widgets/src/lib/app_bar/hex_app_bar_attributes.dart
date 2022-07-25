part of 'hex_app_bar.dart';

class HexAppBarAttributes {
  String? title;
  List<HexAppBarButtonAttributes>? left;
  List<HexAppBarButtonAttributes>? right;
  Widget? subWidgets;
  HexBrightness brightness;

  HexAppBarAttributes({
    this.title,
    this.left,
    this.right,
    this.subWidgets,
    this.brightness = HexBrightness.light,
  });

  HexAppBarAttributes copyWith({
    String? title,
    List<HexAppBarButtonAttributes>? left,
    List<HexAppBarButtonAttributes>? right,
    Widget? subWidgets,
  }) =>
      HexAppBarAttributes(
        title: title ?? this.title,
        left: left ?? this.left,
        right: right ?? this.right,
        subWidgets: subWidgets ?? this.subWidgets,
      );
}

class HexAppBarButtonAttributes {
  HexAppBarButtons type;
  TextStyle? textStyle;
  void Function()? onPressed;
  double? iconSize = 36;

  HexAppBarButtonAttributes({
    required this.type,
    this.textStyle,
    this.onPressed,
    this.iconSize,
  });
}

enum HexAppBarButtons {
  back,
  menu,
  search,
  close,
  share,
  more,
  signup,
  info,
}
