import 'package:core/core.dart';
import 'package:core/navigation/i_navigation_handler.dart';
import 'package:example_mobile_app/features/splash/view/splash_view.dart';
import 'package:example_mobile_app/global/global_app_initializer.dart';

Future<void> main() async {
  final core = Core();

  final globalAppInitializer = GlobalAppInitializer();

  await core.registerMinimalDependencies(
    secretSalt: [],
    navigationHandler: DefaultNavigationHandler(),
    appInitializer: globalAppInitializer.appInitializer,
    homeWidget: const SplashView(),
    appTitle: 'Example App',
    packages: {},
  );
}
