part of 'biometrics_auth.dart';

class BiometricsAuthResponse {
  final bool isAuthenticated;
  final String? errorMessage;

  BiometricsAuthResponse({
    required this.isAuthenticated,
    this.errorMessage,
  });
}
