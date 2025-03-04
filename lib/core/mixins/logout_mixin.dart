import 'package:flutter/material.dart';

mixin LogoutMixin {
  @protected
  void logout() {
    // Hard logout user- clear everything
    // sl<AuthProvider>().logout(rootNavigatorKey.currentContext!);
  }

  @protected
  void sessionExpiredLogout({
    String reason =
        'Your session was timed-out due to inactivity on this page.',
  }) {
    // Soft logout user- clear everything
    // sl<AuthProvider>().sessionExpiredLogout(rootNavigatorKey.currentContext!);
  }
}
