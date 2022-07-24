import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseCoordinator<S> extends StateNotifier<S> {
  BaseCoordinator(S state) : super(state);
}
