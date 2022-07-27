import 'package:core/base_classes/base_coordinator.dart';
import 'package:example_mobile_app/features/landing/data_provider/offers_data_provider.dart';

part '../state/landing_state.dart';

class _Constants {
  static const iconPath = 'assets/icons/bag.svg';
  static const bgImagePath = 'assets/images/bg.jpeg';
  static const networkImagePath =
      'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2020/05/Frame-9.png';
}

class LandingCoordinator extends BaseCoordinator<LandingState> {
  final IOfferDataProvider _offerDataProvider;

  LandingCoordinator(
    this._offerDataProvider,
  ) : super(
          LandingState(
            pageTitle: 'Example App',
            iconPath: _Constants.iconPath,
            bgImage: _Constants.bgImagePath,
            networkImage: _Constants.networkImagePath,
          ),
        );

  void initialize() {
    _getofferData();
    _getNumbers();
    _getCategories();
  }

  void _getofferData() {
    _offerDataProvider.getOffersData().then((value) {
      final offers = value
          .map((e) => OfferBannerState(
                title: e.title,
                description: e.description,
                iconPath: e.iconPath,
              ))
          .toList();
      state = state.copyWith(offerBanners: offers);
    });
  }

  void _getNumbers() {
    _offerDataProvider.getNumbers().then((value) {
      state = state.copyWith(nos: value);
    });
  }

  void _getCategories() {
    _offerDataProvider.getCategories().then((value) {
      state = state.copyWith(
        categories: CategoriesState(
            title: 'Categories',
            actionText: 'See All',
            actionIcon: '',
            categories: value.map((e) => CategoryState(title: e, image: 'image')).toList()),
      );
    });
  }
}
