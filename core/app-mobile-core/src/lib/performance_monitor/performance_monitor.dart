import 'package:core/analytics/i_analytics.dart';
import 'package:core/ioc/di_container.dart';
import 'package:core/logging/logger.dart';
import 'package:core/utils/extensions/string_extensions.dart';

class _Constants {
  static const startKey = '-Start';
  static const endKey = '-End';
  static const sessionIdKey = 'x-session-id';
  static const userIdKey = 'user-id';
  static const anonymous = 'anonymous';
  static const screenLaunchKey = '-Screen';
  static const selectedEnvironmentKey = 'environment';
}

class PerformanceMonitor {
  static IAnalytics? _analytics;
  static String? _sessionId;
  static String? _userId;
  static String? _selectedEnvironment;

  /// Initializes the analytics tool with the api and/or project token
  /// defined in the .env.(current environment) file.
  ///
  /// e.g. MixPanelAnalytics does not require an explicit initialization
  /// as it initialzes the tool when first logEvent is executed.
  static void startCollecting() {
    try {
      _analytics = DIContainer.container.resolve<IAnalytics>();
    } on Exception catch (exception) {
      final exceptionMessage = exception.toString();
      // do nothing
      HexLogger.logDebug('could not find analytics object,' + exceptionMessage);
    }
  }

  ///logs common events names with properties
  static void track(String eventName, {Map<String, dynamic>? properties}) {
    final _newProperties = PerformanceMonitorExtension._analyticsProperties(properties);

    // Capture the event
    _analytics?.logEvent(eventName, _newProperties);
  }

  /// This function will begin capturing the time for the given
  /// event(like network calls or any other) in mixpanel[Analytics]
  /// and also sends it to AppCenter to capture the events [PerformanceMonitor]
  static void startTimedEvent(String eventName, {Map<String, dynamic>? properties}) {
    final _newProperties = PerformanceMonitorExtension._analyticsProperties(properties);

    final _appendEventName = '$eventName${_Constants.startKey}';
    // Capture the start event also separately
    _analytics?.logEvent(_appendEventName, _newProperties);

    // Capture the timed event
    _analytics?.logTimedEvent(eventName, _newProperties);
  }

  /// This will end capturing the time for the given
  /// event(like network calls or any other) in mixpanel[Analytics]
  /// and also sends it to AppCenter to capture the events [PerformanceMonitor]
  static void endTimedEvent(String eventName, {Map<String, dynamic>? properties}) {
    final _newProperties = PerformanceMonitorExtension._analyticsProperties(properties);

    final _appendEventName = '$eventName${_Constants.endKey}';
    // Capture the end event separately
    _analytics?.logEvent(_appendEventName, _newProperties);

    // Capture the timed event
    _analytics?.endTimedEvent(eventName, _newProperties);
  }

  /// This function will begin capturing the screen load time in mixpanel[Analytics]
  /// and also sends it to AppCenter to capture the events [PerformanceMonitor]
  static void startScreenLoadTimedEvent(String eventName, {Map<String, dynamic>? properties}) {
    final _newProperties = PerformanceMonitorExtension._analyticsProperties(properties);

    final _appendEventName = '$eventName${_Constants.screenLaunchKey}${_Constants.startKey}';
    // Capture the start event also separately
    _analytics?.logEvent(_appendEventName, _newProperties);

    // Capture the timed event
    _analytics?.logTimedEvent('$eventName${_Constants.screenLaunchKey}', _newProperties);
  }

  /// This function will end capturing the screen load time in mixpanel[Analytics]
  /// and also sends it to AppCenter to capture the events [PerformanceMonitor]
  static void endScreenLoadTimedEvent(String eventName, {Map<String, dynamic>? properties}) {
    final _newProperties = PerformanceMonitorExtension._analyticsProperties(properties);

    final _appendEventName = '$eventName${_Constants.screenLaunchKey}${_Constants.endKey}';
    // Capture the end event separately
    _analytics?.logEvent(_appendEventName, _newProperties);

    // Capture the timed event
    _analytics?.endTimedEvent('$eventName${_Constants.screenLaunchKey}', _newProperties);
  }

  static void updateUserDetails(String sessionId, String userId) {
    PerformanceMonitor._sessionId = sessionId;
    PerformanceMonitor._userId = userId;
    DIContainer.container.resolve<IAnalytics>().registerUser(userId);
  }

  static void setEnvironment(String environment) {
    PerformanceMonitor._selectedEnvironment = environment;
  }
}

extension PerformanceMonitorExtension on PerformanceMonitor {
  static Map<String, dynamic> _analyticsProperties(Map<String, dynamic>? properties) {
    var newProperties = properties ?? {};
    if (PerformanceMonitor._sessionId?.isNotBlank() ?? false) {
      newProperties[_Constants.sessionIdKey] = PerformanceMonitor._sessionId!;
    }
    if (PerformanceMonitor._userId?.isBlank() ?? false) {
      newProperties[_Constants.userIdKey] = PerformanceMonitor._userId!;
    } else {
      newProperties[_Constants.userIdKey] = _Constants.anonymous;
    }

    if (PerformanceMonitor._selectedEnvironment?.isNotBlank() ?? false) {
      newProperties[_Constants.selectedEnvironmentKey] = PerformanceMonitor._selectedEnvironment!;
    }
    return newProperties;
  }
}
