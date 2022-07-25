part of '../coordinator/splash_coordinator.dart';

class SplashState {
  final String title;

  SplashState({
    required this.title,
  });

  SplashState copyWith({
    String? title,
  }) =>
      SplashState(
        title: title ?? this.title,
      );
}
