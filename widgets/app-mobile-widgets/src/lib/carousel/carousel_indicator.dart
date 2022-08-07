part of 'carousel_widget.dart';

class IndicatorAttribute {
  final Color defaultColor;
  final Color currentColor;
  final double defaultSize;
  final double currentsize;
  final bool isOverlay;
  final BoxBorder? border;

  IndicatorAttribute({
    this.defaultColor = Colors.black12,
    this.currentColor = Colors.black,
    this.defaultSize = _Constants.defaultIndicatorSize,
    this.currentsize = _Constants.currentIndicatorSize,
    this.isOverlay = false,
    this.border,
  });
}

class CarouselIndicator extends StatelessWidget {
  final IndicatorAttribute attribute;
  final int count;
  final int currentIndex;

  const CarouselIndicator({
    Key? key,
    required this.attribute,
    required this.count,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) => index)
          .map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
              child: Container(
                height: e == currentIndex ? attribute.currentsize : attribute.defaultSize,
                width: e == currentIndex ? attribute.currentsize : attribute.defaultSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: e == currentIndex ? attribute.currentColor : attribute.defaultColor,
                  border: attribute.border,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
