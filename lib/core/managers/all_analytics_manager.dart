import 'package:kobo_kobo/di/dependency_injection_container.dart';

class AnalyticsEvent {
  static const String userLogin = 'user_login';
}

class AnalyticsManager {
  static AnalyticsManager get instance {
    return sl<AnalyticsManager>();
  }

  void logEvent(String name, {Map<String, dynamic>? parameters}) {}
}
