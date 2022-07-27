part of '../coordinator/images_coordinator.dart';

class ImagesState {
  final String iconTitle;
  final String iconPath;
  final String imageTitle;
  final String imagePath;
  final String networkImageTitle;
  final String networkImagePath;

  ImagesState({
    required this.iconTitle,
    required this.iconPath,
    required this.imageTitle,
    required this.imagePath,
    required this.networkImageTitle,
    required this.networkImagePath,
  });
}
