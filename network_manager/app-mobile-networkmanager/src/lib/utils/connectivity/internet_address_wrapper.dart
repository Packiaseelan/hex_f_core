import 'dart:io';

class InternetAddressWrapper {
  /// Wraps the InternetAddress abstract class to allow for dependency injection
  Future<List<InternetAddress>> lookup(String host) async =>
      await InternetAddress.lookup(host);
}
