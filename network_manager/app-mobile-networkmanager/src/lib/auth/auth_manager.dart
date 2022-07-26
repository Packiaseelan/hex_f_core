import 'package:core/logging/logger.dart';
import 'package:core/performance_monitor/performance_monitor.dart';
import 'package:core/storage/secure_storage/secure_storage_service.dart';
import 'package:core/utils/extensions/string_extensions.dart';

import 'package:network_manager/auth/i_auth_manager.dart';

class AuthManager implements IAuthManager {
  static const _refreshTokenKey = 'refresh_token';
  static const _expiryDateKey = 'expiry_date';

  // the expiry buffer is to mitigate latency from the connection between client and server.
  // when a token is generated so is its expiry time in seconds.
  static const _expiryBuffer = 30;

  String? _accessToken;

  final SecureStorageService _secureStorageService;

  String? _individualId;
  String? _sessionId;

  AuthManager(this._secureStorageService);

  @override
  String sessionId() {
    return _sessionId ?? _individualId ?? '';
  }

  @override
  Future<String?> getAccessToken() async {
    HexLogger.logInfo('Attempting to retrieve access token');
    //AuthManager should not be responsible for refreshing,or should it be?
    //if is responsible then AuthManager has dependency on TaskManager
    //and TaskManager has dependency on AuthManager via NetworkClient
    // final expiryDateTime = await getExpireTime();
    // if (DateTime.now().toUtc().isAfter(expiryDateTime!)) {
    //   await _refreshAccessToken();
    // }
    return _accessToken;
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _secureStorageService.get(_refreshTokenKey);
  }

  @override
  Future<DateTime?> getExpireTime() async {
    final expiryDateStr = await _secureStorageService.get(_expiryDateKey);
    if (expiryDateStr.isBlank()) {
      return null;
    }
    return DateTime.parse(expiryDateStr!).toUtc();
  }

  @override
  Future<bool> isUserAuthenticated() async => _accessToken != null && _accessToken!.isNotEmpty;

  void _setAccessToken(String accessToken) {
    _accessToken = accessToken;
  }

  Future _setRefreshToken(String refreshToken) async => await _secureStorageService.set(
        _refreshTokenKey,
        refreshToken,
      );

  Future _setExpireTime(String expiresIn) async {
    final expiresInNumber = int.parse(expiresIn);
    final expiresDateTime = DateTime.now().add(Duration(seconds: expiresInNumber - _expiryBuffer)).toUtc();
    await _secureStorageService.set(_expiryDateKey, expiresDateTime.toString());
  }

  void _setIndividualId(String individualId) {
    _individualId = individualId;
  }

  ///Clear everything except refreshToken which we need for biometrics login
  @override
  Future<void> clearState() async {
    _sessionId = '';
    PerformanceMonitor.updateUserDetails('', '');
    _setAccessToken('');
    await _secureStorageService.set(_expiryDateKey, null);
    _setIndividualId('');
  }

  @override
  Future storeTokenInformation({
    required String accessToken,
    required String sessionId,
    required String refreshToken,
    required String expiresIn,
    required String individualId,
  }) async {
    _sessionId = sessionId;
    PerformanceMonitor.updateUserDetails(sessionId, individualId);
    _setAccessToken(accessToken);
    await _setRefreshToken(refreshToken);
    await _setExpireTime(expiresIn);
    _setIndividualId(individualId);
  }
}
