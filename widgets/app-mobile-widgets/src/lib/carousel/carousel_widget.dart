import 'package:flutter/material.dart';

part 'carousel_indicator.dart';

class _Constants {
  static const defaultPadding = 18.0;
  static const defaultSpacing = 10.0;
  static const defaultViewport = 0.8;
  static const defaultHeightFactor = 0.2;
  static const defaultIndicatorSize = 6.0;
  static const currentIndicatorSize = 7.0;

}

class CarouselAttribute {
  final List<Widget> children;
  final double? width;
  final double? height;
  final IndicatorAttribute? indicator;
  final double viewportFraction;
  final double padding;
  final double spacing;

  bool get showIndicator {
    return indicator != null && children.length > 1;
  }

  CarouselAttribute({
    this.children = const [],
    this.width,
    this.height,
    this.indicator,
    this.viewportFraction = _Constants.defaultViewport,
    this.padding = _Constants.defaultPadding,
    this.spacing = _Constants.defaultSpacing,
  });
}

class CarouselWidget extends StatefulWidget {
  final CarouselAttribute attribute;

  const CarouselWidget({Key? key, required this.attribute}) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late PageController ctrl;
  int _currentIndex = 0;
  int childrenCount = 0;

  @override
  void initState() {
    ctrl = PageController(viewportFraction: widget.attribute.viewportFraction);
    childrenCount = widget.attribute.children.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: widget.attribute.height ?? size.height * _Constants.defaultHeightFactor,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              padEnds: false,
              controller: ctrl,
              itemCount: widget.attribute.children.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? widget.attribute.padding : widget.attribute.spacing,
                    right: index == childrenCount - 1 ? widget.attribute.padding : 0,
                  ),
                  child: widget.attribute.children[index],
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
