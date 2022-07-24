import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

part 'biometrics_auth_response.dart';

class BiometricsAuth {
  final LocalAuthentication _auth = LocalAuthentication();
  final String reason;
  final String cancelButtonTitle;
  final String goToSettingsTitle;
  final String goToSettingsMessage;
  final String? signInTitle;

  BiometricsAuth({
    required this.reason,
    required this.cancelButtonTitle,
    required this.goToSettingsTitle,
    required this.goToSettingsMessage,
    this.signInTitle,
  });

  Future<BiometricsAuthResponse> authenticate() async {
    try {
      final availableBiometrics = await _auth.getAvailableBiometrics();

      if (availableBiometrics.isEmpty) {
        return BiometricsAuthResponse(
          isAuthenticated: false,
          errorMessage: 'No Biometrics Available',
        );
      }

      final authenticated = await _auth.authenticate(
        localizedReason: reason,
        authMessages: [
          AndroidAuthMessages(
            signInTitle: signInTitle ?? '',
            cancelButton: cancelButtonTitle,
            goToSettingsButton: goToSettingsTitle,
            goToSettingsDescription: goToSettingsMessage,
          ),
          IOSAuthMessages(
            cancelButton: cancelButtonTitle,
            goToSettingsButton: goToSettingsTitle,
            goToSettingsDescription: goToSettingsMessage,
          ),
        ],
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      return BiometricsAuthResponse(isAuthenticated: authenticated);
    } on PlatformException catch (e) {
      return BiometricsAuthResponse(
        isAuthenticated: false,
        errorMessage: 'Biometrics Platform Exception $e',
      );
    }
  }

  Future<void> cancelAuthentication() async {
    await _auth.stopAuthentication();
  }
}
