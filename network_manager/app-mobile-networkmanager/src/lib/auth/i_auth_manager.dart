abstract class IAuthManager {
  /// Retrieves the access token for the currently authenticated user.
  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<DateTime?> getExpireTime();

  /// Determines whether or not the user has already authenticated with the platform.
  Future<bool> isUserAuthenticated();

  String sessionId();

  ///Clear everything except refreshToken which we need for biometrics login
  Future<void> clearState();

  /// Stores the relevant token information that can be retrieved from login or registration
  /// calls.
  Future storeTokenInformation({
    required String accessToken,
    required String sessionId,
    required String refreshToken,
    required String expiresIn,
    required String individualId,
  });
}
