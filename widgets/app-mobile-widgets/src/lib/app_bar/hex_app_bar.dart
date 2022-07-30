import 'package:flutter/material.dart';

import 'package:core/navigation/navigation_manager.dart';
import 'package:core/utils/extensions/iterable_extensions.dart';
import 'package:widget_library/scaffold/hex_scaffold.dart';

part 'hex_app_bar_attributes.dart';

class _Constants {
  static const double marginWidth = 32;
  static const double defaultIconWidth = 30.0;
}

void _handleAppBarButtonClick(HexAppBarButtons type) {
  switch (type) {
    case HexAppBarButtons.back:
    case HexAppBarButtons.close:
      NavigationManager.goBack();
      break;
    default:
      break;
  }
}

Widget _getIcon(
  BuildContext context,
  HexAppBarButtonAttributes attributes,
  Color color,
  bool isRight,
) {
  switch (attributes.type) {
    case HexAppBarButtons.back:
      return Icon(
        Icons.arrow_back_ios,
        key: const Key('HexAppBarButtons_BackIcon'),
        color: color,
        size: attributes.iconSize,
      );

    case HexAppBarButtons.close:
      return Icon(
        Icons.close,
        key: const Key('HexAppBarButtons_CloseIcon'),
        color: color,
        size: attributes.iconSize,
      );

    case HexAppBarButtons.menu:
      return Icon(
        Icons.menu,
        key: const Key('HexAppBarButtons_MenuIcon'),
        color: color,
        size: attributes.iconSize,
      );

    case HexAppBarButtons.more:
      return Icon(
        Icons.more_horiz_sharp,
        key: const Key('HexAppBarButtons_Horiz_sharpIcon'),
        color: color,
        size: attributes.iconSize,
      );

    case HexAppBarButtons.search:
      return Icon(
        Icons.search,
        key: const Key('HexAppBarButtons_SearchIcon'),
        color: color,
        size: attributes.iconSize,
      );

    case HexAppBarButtons.share:
      return Icon(
        Icons.ios_share,
        key: const Key('HexAppBarButtons_ShareIcon'),
        color: color,
        size: attributes.iconSize,
      );

    case HexAppBarButtons.info:
      return Icon(
        Icons.info_outline_rounded,
        key: const Key('HexAppBarButtons_InfoIcon'),
        color: color,
        size: attributes.iconSize,
      );

    case HexAppBarButtons.cart:
      return Icon(
        Icons.shopping_cart_outlined,
        key: const Key('HexAppBarButtons_CartIcon'),
        color: color,
        size: attributes.iconSize,
      );

    default:
      return Container(
        key: const Key('HexAppBarButtons_NullContainer'),
      );
  }
}

List<Widget> _createAppBarButtons(
  List<HexAppBarButtonAttributes> buttonAttributesList, {
  required BuildContext context,
  bool isRight = false,
  ThemeData? theme,
}) {
  final mainTheme = theme ?? Theme.of(context);
  final color = isRight ? mainTheme.appBarTheme.actionsIconTheme?.color : mainTheme.appBarTheme.iconTheme?.color;
  var buttons = buttonAttributesList
      .mapIndexed(
        (item, index) => Container(
          key: Key('createAppBarButtons_Container$index'),
          child: GestureDetector(
            key: Key('createAppBarButtons_GestureDetector$index'),
            onTap: (item.onPressed != null) ? item.onPressed! : () => _handleAppBarButtonClick(item.type),
            child: _getIcon(
              context,
              item,
              color ?? mainTheme.appBarTheme.foregroundColor!,
              isRight,
            ),
          ),
        ),
      )
      .toList();
  final spacer = Container(
    key: const Key('createAppBarButtons_ContainerWidth_'),
    width: _Constants.marginWidth,
  );
  if (isRight) {
    buttons.add(spacer);
  } else {
    buttons.insert(0, spacer);
  }
  return buttons;
}

PreferredSizeWidget hexDefaultAppBar(
  BuildContext context,
  HexAppBarAttributes attributes,
  ThemeData theme,
) {
  final leadingWidth = _Constants.marginWidth + (_Constants.defaultIconWidth * (attributes.left?.length ?? 0.0));
  return AppBar(
    key: const Key('hexDefaultAppBar_AppBar'),
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: (attributes.left != null)
        ? Row(
            key: const Key('hexDefaultAppBar_Row'),
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: _createAppBarButtons(
              attributes.left ?? [],
              context: context,
              theme: theme,
            ),
          )
        : null,
    leadingWidth: leadingWidth,
    title: _createTitle(
      context,
      attributes,
      theme,
    ),
    actions: (attributes.right != null)
        ? _createAppBarButtons(
            attributes.right!,
            context: context,
            isRight: true,
            theme: theme,
          )
        : null,
    elevation: 0,
  );
}

Widget _createTitle(
  BuildContext context,
  HexAppBarAttributes attributes,
  ThemeData theme,
) {
  if (attributes.title != null) {
    return FittedBox(
      key: const Key('createTitle_FittedBox'),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 1, minHeight: 1),
        child: Text(
          attributes.title!,
          key: const Key('createTitle_Text'),
          style: theme.appBarTheme.titleTextStyle!.copyWith(fontSize: 14),
        ),
      ),
    );
  }
  return Container(key: const Key('createTitle_Container'));
}
