import 'package:core/navigation/i_route_manager.dart';
import 'package:core/navigation/navigation_arguments.dart';
import 'package:core/navigation/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class INavigationHandler {
  static final _routeManager = <String, IRouteManager>{};

  void registerRouteManager(String featureName, IRouteManager routeManager) {
    _routeManager[featureName] = routeManager;
  }

  Route getRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name!);
    final namaes = uri.pathSegments[0].split('-');
    final featureName = namaes[0];
    final viewName = namaes[1];
    final navigationArguments = NavigationArguments.getNavigationArguments(settings);
    final routeSettings = RouteSettings(
      name: viewName,
      arguments: navigationArguments.newScreenArguments ?? uri.queryParameters,
    );
    final view = _routeManager[featureName]!.getView(routeSettings);

    return GetPageRoute(
      page: () => view,
      settings: routeSettings,
      fullscreenDialog: navigationArguments.presentAsModal,
    );
  }

  Future<dynamic> navigateTo(
    String routeName,
    NavigationType navigationType, {
    dynamic arguments,
    bool barrierDismissiable = false,
  }) async {
    switch (navigationType) {
      case NavigationType.Push:
        return _push(routeName, arguments: arguments);

      case NavigationType.Replace:
        return _replaceTo(routeName);

      case NavigationType.ReplaceCurrent:
        return _replaceCurrent(routeName);

      case NavigationType.FullScreenDialog:
        return _push(routeName, arguments: arguments, presentAsModal: true);

      case NavigationType.Dialog:
        return _showDialogNamed(
          routeName,
          arguments: arguments,
          barrierDismissiable: barrierDismissiable,
        );

      case NavigationType.BottomSheet:
        return _showBottomSheetNamed(
          routeName,
          arguments: arguments,
          isDismissible: barrierDismissiable,
        );

      case NavigationType.PopUntil:
        return _popUntil(routeName);

      default:
        throw Exception('Navigation type $navigationType does not exists');
    }
  }

  void goBack({arguments}) => Get.back(result: arguments);

  void popDialog({arguments}) => goBack(arguments: arguments);

  bool canPop(BuildContext context) => Navigator.of(context).canPop();

  String get getCurrentRouteName => Get.currentRoute;

  String get getPreviousRouteName => Get.previousRoute;

  Future<dynamic> _push(String routeName, {dynamic arguments, bool presentAsModal = false}) {
    return Get.toNamed(
          routeName,
          arguments: NavigationArguments(presentAsModal, arguments),
        ) ??
        Future.value();
  }

  Future<dynamic> _replaceTo(String routeName, {dynamic arguments}) async {
    final names = routeName.split('-');
    var replaceNow = false;

    return Get.offNamedUntil(
          routeName,
          (route) {
            final preReplaceNow = replaceNow;
            replaceNow = names[1] == route.settings.name;
            return preReplaceNow;
          },
          arguments: NavigationArguments(false, arguments),
        ) ??
        Future.value();
  }

  Future<dynamic> _replaceCurrent(String routeName, {dynamic arguments}) async {
    return Get.offNamed(
          routeName,
          arguments: NavigationArguments(false, arguments),
        ) ??
        Future.value();
  }

  Future _showDialogNamed(String dialogName, {dynamic arguments, bool barrierDismissiable = false}) {
    final names = dialogName.split('-');
    final featureName = names[0];
    final widgetName = names[1];
    final dialogWidget = _routeManager[featureName]!.getDialog(widgetName, arguments);
    final isTransparentBarrire =
        arguments['transparentBarrier'] == null ? false : arguments['transparentBarrier'] as String == 'true';
    return Get.dialog(
      dialogWidget,
      barrierColor: isTransparentBarrire ? Colors.transparent : null,
      barrierDismissible: barrierDismissiable,
    );
  }

  Future _showBottomSheetNamed(String bottomSheetName, {dynamic arguments, bool isDismissible = true}) {
    final names = bottomSheetName.split('-');
    final featureName = names[0];
    final widgetName = names[1];
    final dialogWidget = _routeManager[featureName]!.getBottomSheet(widgetName, arguments);

    if (arguments != null && arguments is Map<String, dynamic> && arguments.isNotEmpty) {
      return Get.bottomSheet(
        dialogWidget,
        isScrollControlled: arguments['isScrollControlled'] as bool? ?? false,
        backgroundColor: arguments['backgroundColor'] as Color? ?? Colors.white,
        isDismissible: arguments['isDismissible'] as bool? ?? false,
        shape: arguments['shape'] as ShapeBorder?,
      );
    }

    return Get.bottomSheet(
      dialogWidget,
      isScrollControlled: false,
      isDismissible: isDismissible,
    );
  }

  void _popUntil(String routeName) {
    final names = routeName.split('-');
    Get.until((route) => route.settings.name == names[0]);
  }
}

class DefaultNavigationHandler extends INavigationHandler {}