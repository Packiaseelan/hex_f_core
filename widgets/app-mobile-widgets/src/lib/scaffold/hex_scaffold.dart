import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:widget_library/app_bar/hex_app_bar.dart';
import 'package:widget_library/theme/hex_theme.dart';

enum HexBrightness { dark, light }

class HexScaffold extends StatelessWidget {
  final String? themeName;
  final HexAppBarAttributes? appBarAttributes;
  final HexBrightness themeBrightness;
  final PreferredSizeWidget? Function(BuildContext)? appBarBuilder;
  final bool resizeToAvoidBottomInset;
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool extendedBodyClip;
  final bool extendBodyBehindAppBar;

  const HexScaffold({
    Key? key,
    this.themeName,
    this.appBarAttributes,
    this.appBarBuilder,
    this.resizeToAvoidBottomInset = true,
    this.extendedBodyClip = false,
    this.extendBodyBehindAppBar = false,
    required this.body,
    this.bottomNavigationBar,
    this.themeBrightness = HexBrightness.light,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = HexTheme().themeFor(themeName);
    return Theme(
      data: theme,
      key: const Key('Hex_Scaffold_Theme'),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          // For Android.
          // Use [light] for white status bar and [dark] for black status bar.
          statusBarIconBrightness: themeBrightness == HexBrightness.dark ? Brightness.dark : Brightness.light,
          // For iOS.
          // Use [dark] for white status bar and [light] for black status bar.
          statusBarBrightness: themeBrightness == HexBrightness.dark ? Brightness.dark : Brightness.light,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          appBar: _buildAppBar(context, theme),
          body: body,
          bottomNavigationBar: bottomNavigationBar,
          extendBody: extendedBodyClip,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
        ),
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context, ThemeData theme) {
    if (appBarBuilder != null) {
      return appBarBuilder!(context);
    }

    if (appBarAttributes != null) {
      return hexDefaultAppBar(context, appBarAttributes!, theme);
    }

    return null;
  }
}
