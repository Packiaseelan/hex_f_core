import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

class CarouselAttribute {
  final List<Widget> children;
  final double? width;
  final double? height;
  final bool showIndicator;
  final bool enableInfiniteScroll;
  final double aspectRatio;

  CarouselAttribute({
    this.children = const [],
    this.width,
    this.height,
    this.showIndicator = false,
    this.enableInfiniteScroll = false,
    this.aspectRatio = 16 / 9,
  });
}

class CarouselWidget extends StatefulWidget {
  final CarouselAttribute attribute;

  const CarouselWidget({Key? key, required this.attribute}) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: widget.attribute.height ?? size.height * 0.25,
      width: widget.attribute.width ?? size.width,
      child: widget.attribute.children.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : CarouselSlider(
              options: CarouselOptions(
                enableInfiniteScroll: widget.attribute.enableInfiniteScroll,
                aspectRatio: widget.attribute.aspectRatio,
              ),
              items: widget.attribute.children,
            ),
    );
  }
}
