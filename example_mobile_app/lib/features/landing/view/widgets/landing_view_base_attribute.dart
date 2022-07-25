import 'package:widget_library/hex_text/hex_text.dart';
import 'package:widget_library/image/hex_image_widget.dart';

class LandingViewBaseAttribute {
  final TextUIDataModel title;
  final HexImageModel icon;
  final HexImageModel image;
  final HexImageModel networkImage;

  LandingViewBaseAttribute({
    required this.title,
    required this.icon,
    required this.image,
    required this.networkImage,
  });
}
