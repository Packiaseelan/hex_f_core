import 'package:core/base_classes/base_coordinator.dart';
import 'package:core/navigation/navigation_manager.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

part '../state/landing_state.dart';
part '../navigation_handler/landing_navigation_handler.dart';

enum Menu { images, carousel }

extension MenuEx on Menu {
  String get title {
    switch (this) {
      case Menu.images:
        return 'Images';
      case Menu.carousel:
        return 'Carousel';
    }
  }

  String get routeName {
    switch (this) {
      case Menu.images:
        return 'images';
      case Menu.carousel:
        return 'carousel';
    }
  }
}

class _Constants {
  static const iconPath = 'assets/icons/bag.svg';
  static const bgImagePath = 'assets/images/bg.jpeg';
  static const networkImagePath =
      'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2020/05/Frame-9.png';
}

class LandingCoordinator extends BaseCoordinator<LandingState> {
  final ILandingNavigationHandler _navigationHandler;

  LandingCoordinator(
    this._navigationHandler,
  ) : super(
          LandingState(
            pageTitle: 'Example App',
            iconPath: _Constants.iconPath,
            bgImage: _Constants.bgImagePath,
            networkImage: _Constants.networkImagePath,
          ),
        );

  void initialize() {
    state = state.copyWith(menu: Menu.values);
  }

  void navigateTo(Menu menu) {
    _navigationHandler.navigateTo(menu.routeName);
  }
}
