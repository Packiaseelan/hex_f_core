import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconButtonAttribute {
  final Widget child;
  final Function() onPressed;

  IconButtonAttribute({
    required this.child,
    required this.onPressed,
  });

  IconButtonAttribute.icon({
    required IconData icon,
    double size = 16,
    required this.onPressed,
  }) : child = Icon(icon, size: size, color: Colors.white,);
}

class IconButtonWidget extends StatelessWidget {
  final IconButtonAttribute attribute;

  const IconButtonWidget({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.green
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: attribute.child,
      ),
    );
  }
}
