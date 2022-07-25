import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum ImageFrom { local, network }

class HexImageModel {
  final String imagePath;
  final EdgeInsets padding;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? boxFit;
  final AlignmentGeometry? alignment;
  final ImageFrom imageFrom;

  HexImageModel({
    required this.imagePath,
    this.width,
    this.padding = const EdgeInsets.all(0),
    this.height,
    this.color,
    this.boxFit,
    this.alignment,
    this.imageFrom = ImageFrom.local,
  });

  HexImageModel.local({
    required this.imagePath,
    this.width,
    this.padding = const EdgeInsets.all(0),
    this.height,
    this.color,
    this.boxFit,
    this.alignment,
  }) : imageFrom = ImageFrom.local;

  HexImageModel.network({
    required this.imagePath,
    this.width,
    this.padding = const EdgeInsets.all(0),
    this.height,
    this.color,
    this.boxFit,
    this.alignment,
  }) : imageFrom = ImageFrom.network;
}

class HexImage extends StatelessWidget {
  final HexImageModel imageModel;

  const HexImage(this.imageModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: imageModel.padding,
      child: _Image(
        imageModel.imagePath,
        width: imageModel.width,
        height: imageModel.height,
        color: imageModel.color,
        boxFit: imageModel.boxFit,
        alignment: imageModel.alignment,
        imageFrom: imageModel.imageFrom,
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? boxFit;
  final AlignmentGeometry? alignment;
  final ImageFrom imageFrom;

  const _Image(
    this.imagePath, {
    Key? key,
    this.width,
    this.height,
    this.color,
    this.boxFit,
    this.alignment,
    required this.imageFrom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = imagePath.split(':');
    if (imageFrom == ImageFrom.network) {
      return _buildNetworkImage();
    }
    return !_isSvg ? _buildImage(list) : _buildSVGImage(list);
  }

  Widget _buildImage(List<String> list) {
    return Image.asset(
      list.length > 1 ? list[1] : list[0],
      package: list.length > 1 ? list[0] : null,
      height: height,
      width: width,
      fit: boxFit ?? BoxFit.fill,
    );
  }

  Widget _buildSVGImage(List<String> list) {
    return SvgPicture.asset(
      list.length > 1 ? list[1] : list[0],
      package: list.length > 1 ? list[0] : null,
      width: width,
      height: height,
      color: color,
      alignment: alignment ?? Alignment.center,
      fit: boxFit ?? BoxFit.contain,
    );
  }

  Widget _buildNetworkImage() {
    return Image.network(
      imagePath,
      height: height,
      width: width,
      fit: boxFit ?? BoxFit.fill,
      loadingBuilder: (context, child, event) {
        if (event == null) {
          return child;
        }
        return const CircularProgressIndicator();
      },
    );
  }

  bool get _isSvg => imagePath.contains('.svg');
}
