import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/logging/logger.dart';

import 'package:network_manager/utils/connectivity/i_connectivity.dart';
import 'package:network_manager/utils/connectivity/internet_address_wrapper.dart';

/// The [ConnectivityListener] actively listens to changes in network state and
/// then checks the internet connectivity when those changes in state occur.
///
/// It allows other classes to subscribe to updates about the state of
/// connection to the internet
class ConnectivityListener implements IConnectivity {
  final StreamController<bool> _connectionChangeController;
  final Connectivity _connectivity;
  final InternetAddressWrapper _internetAddress;

  ConnectivityListener(
    this._connectivity,
    this._connectionChangeController,
    this._internetAddress,
  );

  bool _hasConnection = false;
  bool _isInitialised = false;

  @override
  bool get hasConnection => _hasConnection;

  @override
  Stream<bool> get connectionChange {
    if (!_isInitialised) {
      throw Exception(
        'You must initialise the connection library before using it.',
      );
    }
    return _connectionChangeController.stream;
  }

  @override
  Future initialize() async {
    HexLogger.logInfo<ConnectivityListener>('initialising..');
    // setting initialised property as first command as it could obstruct the
    // creation of services and prevent the app starting when on a slow
    // connection.
    _isInitialised = true;
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    await checkConnection();
  }

  /// Checks the connection status of the device.
  ///
  /// Do not use the result of this function to decide whether you can reliably
  /// make a network request. It only gives you the radio status.
  ///
  /// Instead listen for connectivity changes via [onConnectivityChanged] stream.
  @override
  Future<bool> checkConnection() async {
    var connectivityResult = await (_connectivity.checkConnectivity());
    return (ConnectivityResult.none != connectivityResult);
  }

  ///Listens for connectivity changes via [onConnectivityChanged] stream.
  void _connectionChange(ConnectivityResult result) async {
    _hasConnection = (ConnectivityResult.none != result);
  }

  // closes the stream
  void dispose() {
    _connectionChangeController.close();
  }
}
