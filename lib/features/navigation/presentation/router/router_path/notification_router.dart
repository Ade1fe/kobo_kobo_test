import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kobo_kobo/features/applicants_dashboard/loan_status_screen.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';

import '../../../../guarantors_dashboard/guarantor.dart';
import '../../../../notification/notify.dart';

List<GoRoute> notificationRouters = [
  GoRoute(
    path: AppRoutes.notificationRoute.routeSplitter(),
    pageBuilder: (context, state) => CustomPageTransition(
      widget: const NotifyScreen(),
      direction: AxisDirection.up,
      pageKey: state.pageKey,
      durationInMillIs: 300,
    ),
    routes: [
      GoRoute(
        path: AppRoutes.loanStatusScreen,
        builder: (context, state) {
          // Extracting the required arguments from `state.extra`
          final extra = state.extra as Map<String, dynamic>?;

          if (extra == null ||
              !extra.containsKey('title') ||
              !extra.containsKey('imagePath') ||
              !extra.containsKey('message') ||
              !extra.containsKey('primaryButtonText') ||
              !extra.containsKey('primaryAction')) {
            return const Scaffold(
              body: Center(child: Text('No Loan Details Found')),
            );
          }

          // Passing arguments to the LoanStatusScreen
          return LoanStatusScreen(
            title: extra['title'] as String,
            imagePath: extra['imagePath'] as String,
            message: extra['message'] as String,
            primaryButtonText: extra['primaryButtonText'] as String,
            primaryAction: extra['primaryAction'] as VoidCallback,
            secondaryButtonText: extra['secondaryButtonText'] as String?,
            secondaryAction: extra['secondaryAction'] as VoidCallback?,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.guarantorsPin,
        pageBuilder: (context, state) {
          final args = state.extra as GuarantorsPinArgs?;
          return CustomPageTransition(
            widget: GuarantorsPin(
              args: args ?? GuarantorsPinArgs.empty(),
              onPinEntered: (pin) {
                print('PIN entered: $pin');
              },
            ),
            direction: AxisDirection.up,
            pageKey: state.pageKey,
            durationInMillIs: 300,
          );
        },
      ),
    ],
  ),
];
