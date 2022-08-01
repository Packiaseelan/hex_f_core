import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

enum ImageSource { asset, network, icon }

class HexImageModel {
  final String imagePath;
  final EdgeInsets padding;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? boxFit;
  final AlignmentGeometry? alignment;
  final ImageSource imageSource;
  final IconData? icon;
  final double? iconSize;

  HexImageModel({
    required this.imagePath,
    this.width,
    this.padding = const EdgeInsets.all(0),
    this.height,
    this.color,
    this.boxFit,
    this.alignment,
    this.imageSource = ImageSource.asset,
    this.icon,
    this.iconSize,
  });

  HexImageModel.asset({
    required this.imagePath,
    this.width,
    this.padding = EdgeInsets.zero,
    this.height,
    this.color,
    this.boxFit,
    this.alignment,
  })  : imageSource = ImageSource.asset,
        icon = null, iconSize = null;

  HexImageModel.network({
    required this.imagePath,
    this.width,
    this.padding = EdgeInsets.zero,
    this.height,
    this.color,
    this.boxFit,
    this.alignment,
  })  : imageSource = ImageSource.network,
        icon = null, iconSize = null;

  HexImageModel.icon({
    required this.icon,
    this.iconSize,
    this.width,
    this.padding = EdgeInsets.zero,
    this.height,
    this.color,
    this.boxFit,
    this.alignment,
  })  : imagePath = '',
        imageSource = ImageSource.icon;
}

class HexImage extends StatelessWidget {
  final HexImageModel imageModel;

  const HexImage(this.imageModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: imageModel.padding,
      child: imageModel.imageSource == ImageSource.icon ? _buildIcon() : _buildImage(),
    );
  }

  Widget _buildImage() {
    return _Image(
      imageModel.imagePath,
      width: imageModel.width,
      height: imageModel.height,
      color: imageModel.color,
      boxFit: imageModel.boxFit,
      alignment: imageModel.alignment,
      imageSource: imageModel.imageSource,
    );
  }

  Widget _buildIcon() {
    return Icon(
      imageModel.icon!,
      color: imageModel.color,
      size: imageModel.iconSize,
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
  final ImageSource imageSource;

  const _Image(
    this.imagePath, {
    Key? key,
    this.width,
    this.height,
    this.color,
    this.boxFit,
    this.alignment,
    required this.imageSource,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = imagePath.split(':');
    if (imageSource == ImageSource.network) {
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
      color: color,
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
