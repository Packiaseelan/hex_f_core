import 'package:example_mobile_app/features/landing/view/widgets/categories_widget.dart';
import 'package:widget_library/hex_text/hex_text.dart';
import 'package:widget_library/image/hex_image_widget.dart';

class LandingViewBaseAttribute {
  final TextUIDataModel title;
  final HexImageModel icon;
  final HexImageModel image;
  final HexImageModel networkImage;
  final List<int> nos;
  final CategoriesAttribute? categories;

  LandingViewBaseAttribute({
    required this.title,
    required this.icon,
    required this.image,
    required this.networkImage,
    this.nos = const [],
    this.categories,
  });
}
