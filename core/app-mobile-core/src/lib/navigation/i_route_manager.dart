import 'package:flutter/material.dart';

abstract class IRouteManager {
  Widget getView(RouteSettings settings) {
    throw Exception('Route ${settings.name} not found');
  }

  Widget getDialog(String dialogName, dynamic arguments) {
    throw Exception('BottomSheet $dialogName not found');
  }

  Widget getBottomSheet(String bottomSheetName, dynamic arguments) {
    throw Exception('BottomSheet $bottomSheetName not found');
  }
}
