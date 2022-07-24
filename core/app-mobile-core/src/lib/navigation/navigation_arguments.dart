import 'package:flutter/material.dart';

class NavigationArguments {
  final bool presentAsModal;
  final dynamic newScreenArguments;

  NavigationArguments(this.presentAsModal, this.newScreenArguments);

  static NavigationArguments getNavigationArguments(RouteSettings settings) {
    if (settings.arguments == null) return NavigationArguments(false, null);
    return settings.arguments as NavigationArguments;
  }
}
