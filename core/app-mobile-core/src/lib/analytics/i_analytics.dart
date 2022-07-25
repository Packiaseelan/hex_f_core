import 'dart:async';

typedef AnalyticsInitializeStatus = FutureOr<void> Function(bool status);

abstract class IAnalytics {
  /// Initializes the analytics tool with the api and/or project token
  /// defined in the .env.(current environment) file.
  ///
  /// e.g. MixPanelAnalytics does not require an explicit initialization
  /// as it initialzes the tool when first logEvent is executed.
  void initializeAnalyticsTool({String? projectToken, AnalyticsInitializeStatus? status});

  /// Registers a user with the [individualId] of the account to allow
  /// tracking of a specific users journey through the application.
  void registerUser(String individualId);

  /// Registers additional user properties with the analytics provider.
  /// [key] is used for the property name and [value] for the property value.
  /// ! [registerUser] must be called prior to executing this method !
  void registerUserProperty(String key, String value);

  /// Logs the screen the user is currently visiting to the anlaytics provider
  /// using the [screenName] as the identifier.
  void logScreen(String screenName);

  /// Logs an event to the analytics provider. The [eventName] is used to
  /// define the type of event that is occuring and the [properties] are
  /// present to allow additional properties to be declared for a single event.
  void logEvent(String eventName, [Map<String, dynamic>? properties]);

  /// Logs an event to the analytics provider. The [eventName] is used to
  /// define the type of event that is occuring and the [properties] are
  /// present to allow additional properties to be declared for a single event.
  void logTimedEvent(String eventName, [Map<String, dynamic>? properties]);

  /// Logs an event to the analytics provider. The [eventName] is used to
  /// define the type of event that is occuring and the [properties] are
  /// present to allow additional properties to be declared for a single event.
  void endTimedEvent(String eventName, [Map<String, dynamic>? properties]);
}
