part of '../coordinator/landing_coordinator.dart';

class LandingState {
  final String pageTitle;

  LandingState({
    required this.pageTitle,
  });

  LandingState copyWith({
    String? pageTitle,
  }) =>
      LandingState(
        pageTitle: pageTitle ?? this.pageTitle,
      );
}
