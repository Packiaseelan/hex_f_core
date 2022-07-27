import 'package:flutter/widgets.dart';

import 'package:core/session_management/inactivity_service.dart';
import 'package:core/logging/logger.dart';

/// Picks up the user's interaction with the screen and forwards
/// them to be handled by the [InactivityService]
/// Also listens to the App Lifecycle and forwards these to the InactivityService
class InactivityWatcher extends StatefulWidget {
  final Widget child;
  final IInactivityService inactivityService;
  const InactivityWatcher({Key? key, required this.inactivityService, required this.child}): super(key: key);

  @override
  State<StatefulWidget> createState() => _InactivityWatcherState();
}

class _InactivityWatcherState extends State<InactivityWatcher> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // Hook into the app Lifecycle to pick up changes to the
    // foreground/background states.
    HexLogger.logDebug('App lifecycle changed $state');

    switch (state) {
      case AppLifecycleState.resumed:
        // We're back
        await widget.inactivityService.movedToForeground();
        break;
      case AppLifecycleState.inactive:
        // We've gone
        await widget.inactivityService.movedToBackground();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (e) {
        widget.inactivityService.registerInteraction(e);
      },
      child: widget.child,
    );
  }
}
