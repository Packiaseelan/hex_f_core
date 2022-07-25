import 'package:core/analytics/i_analytics.dart';

class DefaultAnalyticsHandler implements IAnalytics {
  @override
  void initializeAnalyticsTool({String? projectToken, AnalyticsInitializeStatus? status}) {
    // TODO: implement initializeAnalyticsTool
  }

  @override
  void logEvent(String eventName, [Map<String, dynamic>? properties]) {
    // TODO: implement logEvent
  }

  @override
  void logScreen(String screenName) {
    // TODO: implement logScreen
  }

  @override
  void logTimedEvent(String eventName, [Map<String, dynamic>? properties]) {
    // TODO: implement logTimedEvent
  }

  @override
  void endTimedEvent(String eventName, [Map<String, dynamic>? properties]) {
    // TODO: implement logTimedEvent
  }

  @override
  void registerUser(String individualId) {
    // TODO: implement registerUser
  }

  @override
  void registerUserProperty(String key, String value) {
    // TODO: implement registerUserProperty
  }
}
