import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class _Constants {
  static const squareSize = 30.0;
  static const defaultIconSize = 16.0;
}

class IconButtonAttribute {
  final Widget child;
  final Function() onPressed;

  IconButtonAttribute({
    required this.child,
    required this.onPressed,
  });

  IconButtonAttribute.icon({
    required IconData icon,
    double size = _Constants.defaultIconSize,
    required this.onPressed,
  }) : child = Icon(
          icon,
          size: size,
          color: Colors.white,
        );
}

class IconButtonWidget extends StatelessWidget {
  final IconButtonAttribute attribute;

  const IconButtonWidget({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _Constants.squareSize,
      height: _Constants.squareSize,
      child: RawMaterialButton(
        fillColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        onPressed: () => attribute.onPressed(),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: attribute.child,
        ),
      ),
    );
  }
}
