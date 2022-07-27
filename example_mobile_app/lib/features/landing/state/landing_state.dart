part of '../coordinator/landing_coordinator.dart';

class LandingState {
  final String pageTitle;
  final String iconPath;
  final String bgImage;
  final String networkImage;
  final List<OfferBannerState> offerBanners;
  final List<int> nos;
  final CategoriesState? categories;

  LandingState({
    required this.pageTitle,
    required this.iconPath,
    required this.bgImage,
    required this.networkImage,
    this.offerBanners = const [],
    this.nos = const [],
    this.categories,
  });

  LandingState copyWith({
    String? pageTitle,
    String? iconPath,
    String? bgImage,
    String? networkImage,
    List<OfferBannerState>? offerBanners,
    List<int>? nos,
    CategoriesState? categories,
  }) =>
      LandingState(
        pageTitle: pageTitle ?? this.pageTitle,
        iconPath: iconPath ?? this.iconPath,
        bgImage: bgImage ?? this.bgImage,
        networkImage: networkImage ?? this.networkImage,
        offerBanners: offerBanners ?? this.offerBanners,
        nos: nos ?? this.nos,
        categories: categories ?? this.categories,
      );
}

class OfferBannerState {
  final String title;
  final String description;
  final String iconPath;

  OfferBannerState({
    required this.title,
    required this.description,
    required this.iconPath,
  });
}

class CategoriesState {
  final String title;
  final String actionText;
  final String actionIcon;
  final List<CategoryState> categories;

  CategoriesState({
    required this.title,
    required this.actionText,
    required this.actionIcon,
    required this.categories,
  });
}

class CategoryState {
  final String title;
  final String image;

  CategoryState({required this.title, required this.image});
}
