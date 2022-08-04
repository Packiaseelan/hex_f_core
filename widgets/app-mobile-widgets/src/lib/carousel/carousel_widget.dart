import 'package:flutter/material.dart';

import 'package:widget_library/carousel/carousel_indicator.dart';

class CarouselAttribute {
  final List<Widget> children;
  final double? width;
  final double? height;
  final bool enableInfiniteScroll;
  final double aspectRatio;
  final IndicatorAttribute? indicator;
  final double viewportFraction;

  bool get showIndicator {
    return indicator != null && children.length > 1;
  }

  CarouselAttribute(
      {this.children = const [],
      this.width,
      this.height,
      this.enableInfiniteScroll = false,
      this.aspectRatio = 16 / 9,
      this.indicator,
      this.viewportFraction = 0.8});
}

class CarouselWidget extends StatefulWidget {
  final CarouselAttribute attribute;

  const CarouselWidget({Key? key, required this.attribute}) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final PageController ctrl = PageController(viewportFraction: 0.7);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: widget.attribute.height ?? size.height * 0.2,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              padEnds: false,
              controller: ctrl,
              itemCount: widget.attribute.children.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 18 : 10, right: index == 3 ? 18 : 0),
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: widget.attribute.children[index],
                  ),
                );
              },
              onPageChanged: _onPageChange,
            ),
          ),
          if (widget.attribute.showIndicator)
            CarouselIndicator(
              attribute: IndicatorAttribute(),
              count: widget.attribute.children.length,
              currentIndex: _currentIndex,
            ),
        ],
      ),
    );
  }

  void _onPageChange(int index) {
    setState(() => _currentIndex = index);
  }
}
