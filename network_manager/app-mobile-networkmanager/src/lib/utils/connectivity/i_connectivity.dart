import 'dart:async';

abstract class IConnectivity {
  /// Retrieves a boolean value representing whether the application currently
  /// has connection to the internet.
  bool get hasConnection;

  /// Retrieves a stream that observing classes can listen to in order to
  /// receive updates on whether or not the application is connected
  /// to the internet.
  Stream<bool> get connectionChange;

  /// Initializes the connectivity listener and subscribes it to listen for
  /// changes in the network.
  Future initialize();

  /// Checks the applications connection to the internet and returns a boolean
  /// value that indicates whether the application has connection to the 
  /// internet.
  Future<bool> checkConnection();
}
