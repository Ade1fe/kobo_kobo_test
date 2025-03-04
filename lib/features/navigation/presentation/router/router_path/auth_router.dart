import 'package:go_router/go_router.dart';
import 'package:kobo_kobo/features/auth/auth.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/features/otp/presentation/screens/otp_screen.dart';
import 'package:kobo_kobo/functional_util/extensions/string.dart';
import 'package:skeletonizer/skeletonizer.dart';

List<GoRoute> authRouter = [
  GoRoute(
    path: AppRoutes.login,
    pageBuilder: (context, state) => CustomPageTransition(
      widget: const LoginScreen(),
      direction: AxisDirection.up,
      pageKey: state.pageKey,
      durationInMillIs: 300,
    ),
    routes: [
      GoRoute(
        path: AppRoutes.forgotPassword.routeSplitter(),
        pageBuilder: (context, state) => CustomPageTransition(
          widget: const ForgotPasswordScreen(),
          direction: AxisDirection.up,
          pageKey: state.pageKey,
          durationInMillIs: 300,
        ),
        routes: [
          GoRoute(
            path: AppRoutes.forgotPasswordOtp.routeSplitter(),
            pageBuilder: (context, state) => CustomPageTransition(
              widget: OTPScreen(
                args: state.extra as OtpScreenArgs,
              ),
              direction: AxisDirection.up,
              pageKey: state.pageKey,
              durationInMillIs: 300,
            ),
            routes: [
              GoRoute(
                path: AppRoutes.resetPassword.routeSplitter(),
                pageBuilder: (context, state) => CustomPageTransition(
                  widget: const CreatePasswordScreen(),
                  direction: AxisDirection.up,
                  pageKey: state.pageKey,
                  durationInMillIs: 300,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  GoRoute(
    path: AppRoutes.signUp,
    builder: (context, state) {
      return const PersonalInformationScreen();
    },
    routes: [
      GoRoute(
        path: AppRoutes.signUpOtp.routeSplitter(),
        pageBuilder: (context, state) => CustomPageTransition(
          widget: OTPScreen(
            args: OtpScreenArgs(
              title: '1/3',
              showLeading: true,
              useSmallFont: true,
              centerTitle: true,
            ),
          ),
          direction: AxisDirection.up,
          pageKey: state.pageKey,
          durationInMillIs: 300,
        ),
        routes: [
          GoRoute(
            path: AppRoutes.signUpOtpCountry.routeSplitter(),
            pageBuilder: (context, state) => CustomPageTransition(
              widget: const PersonalInfoCountry(),
              direction: AxisDirection.up,
              pageKey: state.pageKey,
              durationInMillIs: 300,
            ),
          ),
        ],
      ),
    ],
  ),
  GoRoute(
    path: AppRoutes.signUpBvn,
    pageBuilder: (context, state) => CustomPageTransition(
      widget: const BvnScreen(),
      direction: AxisDirection.up,
      pageKey: state.pageKey,
      durationInMillIs: 300,
    ),
    routes: [
      GoRoute(
        path: AppRoutes.bvnPinLock.routeSplitter(),
        pageBuilder: (context, state) => CustomPageTransition(
          widget: const PinLockScreen(),
          direction: AxisDirection.up,
          pageKey: state.pageKey,
          durationInMillIs: 300,
        ),
        routes: [
          GoRoute(
            path: AppRoutes.lockCreatePin.routeSplitter(),
            pageBuilder: (context, state) => CustomPageTransition(
              widget: const CreatePinScreen(),
              direction: AxisDirection.up,
              pageKey: state.pageKey,
              durationInMillIs: 300,
            ),
          ),
        ],
      ),
    ],
  ),
  GoRoute(
    path: AppRoutes.reasonForKobo,
    pageBuilder: (context, state) => CustomPageTransition(
      widget: const ReasonForKoboScreen(),
      direction: AxisDirection.up,
      pageKey: state.pageKey,
      durationInMillIs: 300,
    ),
  ),
];
