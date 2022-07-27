import 'package:flutter/material.dart';
import 'package:widget_library/sub_title/sub_title_widget.dart';

class CategoriesAttribute {
  final SubTitleAttribute title;

  CategoriesAttribute({required this.title});
}

class CategoriesWidget extends StatelessWidget {
  final CategoriesAttribute attribute;

  const CategoriesWidget({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Column(
        children: [
          SubTitleWidget(attribute: attribute.title),
        ],
      ),
    );
  }
}
