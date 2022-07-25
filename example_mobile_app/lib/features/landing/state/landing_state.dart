part of '../coordinator/landing_coordinator.dart';

class LandingState {
  final String pageTitle;
  final String iconPath;
  final String bgImage;
  final String networkImage;

  LandingState({
    required this.pageTitle,
    required this.iconPath,
    required this.bgImage,
    required this.networkImage,
  });

  LandingState copyWith({
    String? pageTitle,
    String? iconPath,
    String? bgImage,
    String? networkImage,
  }) =>
      LandingState(
        pageTitle: pageTitle ?? this.pageTitle,
        iconPath: iconPath ?? this.iconPath,
        bgImage: bgImage ?? this.bgImage,
        networkImage: networkImage ?? this.networkImage,
      );
}
