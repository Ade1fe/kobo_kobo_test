import 'dart:async';

import 'package:flutter/services.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

/// This is the util class for local auth
class LocalAuthImpl {
  static final _localAuth = LocalAuthentication();

  static Future<bool> checkIfDeviceIsBiometricEnabled() async {
    try {
      final deviceHasBiometricCapabilities =
          await _localAuth.canCheckBiometrics &&
              await _localAuth.isDeviceSupported();
      return deviceHasBiometricCapabilities;
    } catch (e, s) {
      Log().debug(
        e.toString(),
        s,
      );
      return false;
    }
  }

  static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e, s) {
      Log().debug(
        e.toString(),
        s,
      );
      return [];
    }
  }

  static Future<bool> authenticate() async {
    try {
      return _localAuth.authenticate(
        localizedReason: 'Please authenticate to login',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      var message = '';
      switch (e.code) {
        case auth_error.notAvailable:
          message = 'This device does not have a Touch ID/fingerprint scanner.';
          break;
        case auth_error.passcodeNotSet:
          message = 'You are yet configured a password on the device.';
          break;
        case auth_error.notEnrolled:
          message = 'You have not enrolled any fingerprints on the device.';
          break;
        case auth_error.otherOperatingSystem:
          message = 'The device operating system is not iOS or Android';
          break;
        case auth_error.lockedOut:
          message = 'You have been locked out due to too many attempts';
          break;
        case auth_error.permanentlyLockedOut:
          message =
              'Your biometrics has been disabled due to too many lock outs, authentication like PIN/Pattern/Password is required to unlock.';
          break;
        default:
          message = e.toString();
          break;
      }

      showErrorNotification(message);

      return false;
    } catch (e, s) {
      Log().debug(
        e.toString(),
        s,
      );
      return false;
    }
  }
}
