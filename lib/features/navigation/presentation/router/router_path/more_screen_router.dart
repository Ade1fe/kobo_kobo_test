// lib/features/navigation/presentation/router/router_path/more_screen_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';

import '../../../../more/more.dart';

List<GoRoute> moreRoutes = [
  GoRoute(
    path: AppRoutes.more,
    name: 'more',
    pageBuilder: (context, state) => CustomPageTransition(
      widget: const MoreHomePage(),
      direction: AxisDirection.left,
      pageKey: state.pageKey,
      durationInMillIs: 300,
    ),
    routes: [
      GoRoute(
        path: AppRoutes.moreChangePassword,
        name: AppRoutes.moreChangePasswordNamed,
        pageBuilder: (context, state) => CustomPageTransition(
          widget: const ChangePassword(),
          direction: AxisDirection.up,
          pageKey: state.pageKey,
          durationInMillIs: 300,
        ),
      ),
      GoRoute(
        path: AppRoutes.morePinReset,
        name: AppRoutes.morePinResetNamed,
        pageBuilder: (context, state) => CustomPageTransition(
          widget: const PinResetScreen(),
          direction: AxisDirection.up,
          pageKey: state.pageKey,
          durationInMillIs: 300,
        ),
      ),
      GoRoute(
        path: AppRoutes.moreAccountStatement,
        name: AppRoutes.moreAccountStatementNamed,
        pageBuilder: (context, state) => CustomPageTransition(
          widget: const AccountStatement(),
          direction: AxisDirection.up,
          pageKey: state.pageKey,
          durationInMillIs: 300,
        ),
      ),
      GoRoute(
        path: AppRoutes.moreEmploymentDetails,
        name: AppRoutes.moreEmploymentDetailsNamed,
        pageBuilder: (context, state) => CustomPageTransition(
          widget: const EmploymentDetailsScreen(),
          direction: AxisDirection.up,
          pageKey: state.pageKey,
          durationInMillIs: 300,
        ),
      ),
      GoRoute(
        path: AppRoutes.moreChangeTransactionPin,
        name: AppRoutes.moreChangeTransactionPinNamed,
        pageBuilder: (context, state) => CustomPageTransition(
          widget: const ChangeTransactionPin(),
          direction: AxisDirection.up,
          pageKey: state.pageKey,
          durationInMillIs: 300,
        ),
      ),
    ],
  ),
];
