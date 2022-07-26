import 'package:flutter/material.dart';

import 'package:widget_library/hex_text/hex_text.dart';
import 'package:widget_library/image/hex_image_widget.dart';
import 'package:widget_library/carousel/carousel_widget.dart';

import 'package:example_mobile_app/features/landing/view/widgets/landing_view_base_attribute.dart';

class LandingViewBaseWidget extends StatelessWidget {
  final LandingViewBaseAttribute attribute;

  const LandingViewBaseWidget({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HexImage(attribute.icon),
          HexText(text: attribute.title),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(),
          ),
          CarouselWidget(
            attribute: CarouselAttribute(
              children: attribute.nos.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(color: Colors.amber),
                      child: Center(
                        child: Text(
                          'text $i',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Categories(categories: attribute.categories),
          HexImage(attribute.icon),
          HexText(text: attribute.title),
          HexImage(attribute.image),
          HexImage(attribute.image),
          HexImage(attribute.image),
          HexImage(attribute.image),
          HexImage(attribute.networkImage),
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  final List<String> categories;
  const Categories({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Categories'),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(categories[index]),
                  );
                }),
          )
        ],
      ),
    );
  }
}
