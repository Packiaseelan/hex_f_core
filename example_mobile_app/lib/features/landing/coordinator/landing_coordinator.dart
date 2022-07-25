import 'package:core/base_classes/base_coordinator.dart';

part '../state/landing_state.dart';

class _Constants {
  static const iconPath = 'assets/icons/bag.svg';
  static const bgImagePath = 'assets/images/bg.jpeg';
  static const networkImagePath =
      'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2020/05/Frame-9.png';
}

class LandingCoordinator extends BaseCoordinator<LandingState> {
  LandingCoordinator()
      : super(
          LandingState(
            pageTitle: 'Landing Screen',
            iconPath: _Constants.iconPath,
            bgImage: _Constants.bgImagePath,
            networkImage: _Constants.networkImagePath,
          ),
        );

  void initialize() {}
}
