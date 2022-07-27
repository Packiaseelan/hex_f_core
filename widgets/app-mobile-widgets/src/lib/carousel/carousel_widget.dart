import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:widget_library/carousel/carousel_indicator.dart';

class CarouselAttribute {
  final List<Widget> children;
  final double? width;
  final double? height;
  final bool showIndicator;
  final bool enableInfiniteScroll;
  final double aspectRatio;
  final IndicatorAttribute? indicator;

  CarouselAttribute({
    this.children = const [],
    this.width,
    this.height,
    this.showIndicator = false,
    this.enableInfiniteScroll = false,
    this.aspectRatio = 16 / 9,
    this.indicator,
  });
}

class CarouselWidget extends StatefulWidget {
  final CarouselAttribute attribute;

  const CarouselWidget({Key? key, required this.attribute}) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final indicatorHeight = widget.attribute.indicator != null && !widget.attribute.indicator!.isOverlay ? 30 : 0;
    return SizedBox(
      height: widget.attribute.height ?? size.height * 0.2 + indicatorHeight,
      width: widget.attribute.width ?? size.width,
      child: widget.attribute.children.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: widget.attribute.height ?? size.height * 0.2,
                        enableInfiniteScroll: widget.attribute.enableInfiniteScroll,
                        aspectRatio: widget.attribute.aspectRatio,
                        onPageChanged: _onPageChanged,
                      ),
                      items: widget.attribute.children,
                    ),
                    if (widget.attribute.indicator != null && widget.attribute.indicator!.isOverlay)
                      CarouselIndicator(
                        attribute: widget.attribute.indicator!,
                        count: widget.attribute.children.length,
                        currentIndex: _currentIndex,
                      ),
                  ],
                ),
                if (widget.attribute.indicator != null && !widget.attribute.indicator!.isOverlay)
                  CarouselIndicator(
                    attribute: widget.attribute.indicator!,
                    count: widget.attribute.children.length,
                    currentIndex: _currentIndex,
                  ),
              ],
            ),
    );
  }

  void _onPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });
  }
}
