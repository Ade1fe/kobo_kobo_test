import 'package:go_router/go_router.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/features/onboarding/onboarding.dart';

GoRoute onboardingRouter() {
  return GoRoute(
    path: AppRoutes.onboarding,
    builder: (context, state) {
      return const OnboardingScreen();
    },
  );
}
