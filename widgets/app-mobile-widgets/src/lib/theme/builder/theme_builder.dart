import 'package:flutter/material.dart';
import 'package:widget_library/theme/hex_theme.dart';

class ThemeBuilder extends StatelessWidget {
  final String? themeName;
  final WidgetBuilder builder;

  const ThemeBuilder({
    Key? key,
    this.themeName = 'default',
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = HexTheme().themeFor(themeName);
    return Theme(data: theme, child: Builder(builder: builder));
  }
}
