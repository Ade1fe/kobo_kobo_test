import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kobo_kobo/features/bills/bills.dart';
import 'package:kobo_kobo/features/dashboard/dashboard.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/features/navigation/presentation/router/router_path/more_screen_router.dart';
import 'package:kobo_kobo/features/savings/savings.dart';
import 'package:kobo_kobo/features/splash/app_splash_screen.dart';
import 'package:kobo_kobo/features/topUp/top_up.dart';
import 'package:kobo_kobo/features/transfer/transfer.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

import '../../../cards/cards.dart';
import '../../../loans/loans.dart';
import 'router_path/notification_router.dart';

final _savedArgs = {};

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

///use the args registry for situations where multiple nested routes have different argument requirements
T? registerArgs<T>(String key, Object? args) {
  if (args == null) {
    return null;
  }
  if (args is T) {
    _savedArgs[key] = args;
  }
  return _savedArgs[key] as T;
}

GoRouter getBaseRouter() {
  return GoRouter(
    initialLocation: AppRoutes.root,
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: kDebugMode,
    routes: [
      GoRoute(
        path: AppRoutes.root,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      onboardingRouter(),
      ...authRouter,
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          AfrTab? tab;
          bool? hideNav;
          if (state.fullPath != null) {
            if (state.fullPath!.split('/')[1] == 'tab') {
              final tabName = state.fullPath!.split('/')[2];
              tab = AfrTabUtil.fromString(tabName);
              try {
                hideNav = state.fullPath!.split('/')[3].isNotEmpty;
              } catch (e) {
                hideNav = false;
              }
              if (tab == null) {
                throw PageNotFoundException(state.fullPath!);
              }
            }
          }

          return PopScope(
            canPop: false,
            child: Scaffold(
              body: Column(
                children: [
                  Expanded(child: child),
                  if (tab != null)
                    BottomNavigationContainer(
                      selectedTab: tab,
                      hideNav: hideNav ?? false,
                    ),
                ],
              ),
            ),
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) {
              return const DashboardScreen();
            },
            routes: [
              ...notificationRouters,
              
              GoRoute(
                path: AppRoutes.bills.routeSplitter(),
                pageBuilder: (context, state) => CustomPageTransition(
                  widget: const BillsOptionsScreen(),
                  direction: AxisDirection.up,
                  pageKey: state.pageKey,
                  durationInMillIs: 300,
                ),
                routes: [
                  GoRoute(
                    path: AppRoutes.billOptions.routeSplitter(),
                    pageBuilder: (context, state) => CustomPageTransition(
                      widget: CableOptions(
                        args: registerArgs<CableOptionsArgs>(
                              AppRoutes.billOptions.routeSplitter(),
                              state.extra,
                            ) ??
                            CableOptionsArgs.empty(),
                      ),
                      direction: AxisDirection.up,
                      pageKey: state.pageKey,
                      durationInMillIs: 300,
                    ),
                    routes: [
                      GoRoute(
                        path:
                            AppRoutes.electricityOptionsInputs.routeSplitter(),
                        pageBuilder: (context, state) => CustomPageTransition(
                          widget: ElectricityPaymentScreen(
                            args: registerArgs<CablePaymentArgs>(
                                  AppRoutes.electricityOptionsInputs
                                      .routeSplitter(),
                                  state.extra,
                                ) ??
                                CablePaymentArgs.empty(),
                          ),
                          direction: AxisDirection.up,
                          pageKey: state.pageKey,
                          durationInMillIs: 300,
                        ),
                        routes: [
                          GoRoute(
                            path: AppRoutes.electricitySummary.routeSplitter(),
                            pageBuilder: (context, state) {
                              return DialogPage(
                                barrierDismissible: true,
                                useSafeArea: false,
                                barrierColor: Colors.black.withOpacity(0.3),
                                themes: InheritedTheme.capture(
                                    from: context, to: context),
                                builder: (_) {
                                  return BillSummarySheet(
                                    args: registerArgs<BillSummaryArgs>(
                                          AppRoutes.electricitySummary
                                              .routeSplitter(),
                                          state.extra,
                                        ) ??
                                        BillSummaryArgs.empty(),
                                  );
                                },
                              );
                            },
                          ),
                          GoRoute(
                            path:
                                AppRoutes.electricitySummaryPin.routeSplitter(),
                            pageBuilder: (context, state) =>
                                CustomPageTransition(
                              widget: BillPinScreen(
                                args: registerArgs<BillPinArgs>(
                                      AppRoutes.electricitySummaryPin
                                          .routeSplitter(),
                                      state.extra,
                                    ) ??
                                    BillPinArgs.empty(),
                              ),
                              direction: AxisDirection.up,
                              pageKey: state.pageKey,
                              durationInMillIs: 300,
                            ),
                          ),
                        ],
                      ),
                      GoRoute(
                        path: AppRoutes.billOptionsChoice.routeSplitter(),
                        pageBuilder: (context, state) => CustomPageTransition(
                          widget: CableTopUpScreen(
                            args: registerArgs<CablePaymentArgs>(
                                  AppRoutes.billOptionsChoice.routeSplitter(),
                                  state.extra,
                                ) ??
                                CablePaymentArgs.empty(),
                          ),
                          direction: AxisDirection.up,
                          pageKey: state.pageKey,
                          durationInMillIs: 300,
                        ),
                        routes: [
                          GoRoute(
                            path: AppRoutes.billSummary.routeSplitter(),
                            pageBuilder: (context, state) {
                              return DialogPage(
                                barrierDismissible: true,
                                useSafeArea: false,
                                barrierColor: Colors.black.withOpacity(0.3),
                                themes: InheritedTheme.capture(
                                    from: context, to: context),
                                builder: (_) {
                                  return BillSummarySheet(
                                    args: registerArgs<BillSummaryArgs>(
                                          AppRoutes.billSummary.routeSplitter(),
                                          state.extra,
                                        ) ??
                                        BillSummaryArgs.empty(),
                                  );
                                },
                              );
                            },
                          ),
                          GoRoute(
                            path: AppRoutes.billSummaryPin.routeSplitter(),
                            pageBuilder: (context, state) =>
                                CustomPageTransition(
                              widget: BillPinScreen(
                                args: registerArgs<BillPinArgs>(
                                      AppRoutes.billSummaryPin.routeSplitter(),
                                      state.extra,
                                    ) ??
                                    BillPinArgs.empty(),
                              ),
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
                path: AppRoutes.transGenericReceipt.routeSplitter(),
                pageBuilder: (context, state) => CustomPageTransition(
                  widget: const ReceiptScreen(),
                  direction: AxisDirection.up,
                  pageKey: state.pageKey,
                  durationInMillIs: 300,
                ),
              ),
              GoRoute(
                path: AppRoutes.topUp.routeSplitter(),
                pageBuilder: (context, state) => CustomPageTransition(
                  widget: const TopUpScreen(),
                  direction: AxisDirection.up,
                  pageKey: state.pageKey,
                  durationInMillIs: 300,
                ),
                routes: [
                  GoRoute(
                    path: AppRoutes.phoneBook.routeSplitter(),
                    pageBuilder: (context, state) => CustomPageTransition(
                      widget: const ContactList(),
                      direction: AxisDirection.up,
                      pageKey: state.pageKey,
                      durationInMillIs: 300,
                    ),
                  ),
                  GoRoute(
                    path: AppRoutes.topUpDialog.routeSplitter(),
                    pageBuilder: (context, state) {
                      return DialogPage(
                        barrierDismissible: false,
                        useSafeArea: false,
                        barrierColor: Colors.black.withOpacity(0.3),
                        themes:
                            InheritedTheme.capture(from: context, to: context),
                        builder: (_) {
                          return GenericDialogueSheet(
                            args: registerArgs<GenericDialogueArgs>(
                              AppRoutes.topUpDialog.routeSplitter(),
                              state.extra,
                            )!,
                          );
                        },
                      );
                    },
                  ),
                  GoRoute(
                    path: AppRoutes.topUpSummary.routeSplitter(),
                    pageBuilder: (context, state) {
                      return DialogPage(
                        barrierDismissible: true,
                        useSafeArea: false,
                        barrierColor: Colors.black.withOpacity(0.3),
                        themes:
                            InheritedTheme.capture(from: context, to: context),
                        builder: (_) {
                          return TopUpSummarySheet(
                            args: registerArgs<TopUpSummaryArgs>(
                              AppRoutes.topUpSummary.routeSplitter(),
                              state.extra,
                            )!,
                          );
                        },
                      );
                    },
                    routes: [
                      GoRoute(
                        path: AppRoutes.topUpSummaryPin.routeSplitter(),
                        pageBuilder: (context, state) => CustomPageTransition(
                          widget: const TopUpPinScreen(),
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
                path: AppRoutes.transfer.routeSplitter(),
                pageBuilder: (context, state) => CustomPageTransition(
                  widget: const TransferScreen(),
                  direction: AxisDirection.up,
                  pageKey: state.pageKey,
                  durationInMillIs: 300,
                ),
                routes: [
                  GoRoute(
                    path: AppRoutes.bankTransfer.routeSplitter(),
                    pageBuilder: (context, state) => CustomPageTransition(
                      widget: BankOrKoboAccountTransfer(
                        args: registerArgs<BankOrKoboAccountTransferArgs>(
                              AppRoutes.bankTransfer.routeSplitter(),
                              state.extra,
                            ) ??
                            BankOrKoboAccountTransferArgs(koboAccount: false),
                      ),
                      direction: AxisDirection.up,
                      pageKey: state.pageKey,
                      durationInMillIs: 300,
                    ),
                    routes: [
                      GoRoute(
                        path: AppRoutes.bankTransferDialog.routeSplitter(),
                        pageBuilder: (context, state) {
                          return DialogPage(
                            barrierDismissible: true,
                            useSafeArea: false,
                            barrierColor: Colors.black.withOpacity(0.3),
                            themes: InheritedTheme.capture(
                                from: context, to: context),
                            builder: (_) {
                              return GenericDialogueSheet(
                                args: registerArgs<GenericDialogueArgs>(
                                  AppRoutes.bankTransferDialog.routeSplitter(),
                                  state.extra,
                                )!,
                              );
                            },
                          );
                        },
                      ),
                      GoRoute(
                        path: AppRoutes.bankTransferSummary.routeSplitter(),
                        pageBuilder: (context, state) {
                          return DialogPage(
                            barrierDismissible: true,
                            useSafeArea: false,
                            barrierColor: Colors.black.withOpacity(0.3),
                            themes: InheritedTheme.capture(
                                from: context, to: context),
                            builder: (_) {
                              return const TransSummarySheet();
                            },
                          );
                        },
                        routes: [
                          GoRoute(
                            path: AppRoutes.bankTransferSummaryPin
                                .routeSplitter(),
                            pageBuilder: (context, state) =>
                                CustomPageTransition(
                              widget: TransferPinScreen(
                                args: registerArgs<TransferPinArgs>(
                                  AppRoutes.bankTransferSummaryPin
                                      .routeSplitter(),
                                  state.extra,
                                )!,
                              ),
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
                    path: AppRoutes.koboTransfer.routeSplitter(),
                    pageBuilder: (context, state) => CustomPageTransition(
                      widget: BankOrKoboAccountTransfer(
                        args: registerArgs<BankOrKoboAccountTransferArgs>(
                              AppRoutes.koboTransfer.routeSplitter(),
                              state.extra,
                            ) ??
                            BankOrKoboAccountTransferArgs(koboAccount: true),
                      ),
                      direction: AxisDirection.up,
                      pageKey: state.pageKey,
                      durationInMillIs: 300,
                    ),
                    routes: [
                      GoRoute(
                        path: AppRoutes.transferDialog.routeSplitter(),
                        pageBuilder: (context, state) {
                          return DialogPage(
                            barrierDismissible: true,
                            useSafeArea: false,
                            barrierColor: Colors.black.withOpacity(0.3),
                            themes: InheritedTheme.capture(
                                from: context, to: context),
                            builder: (_) {
                              return GenericDialogueSheet(
                                args: registerArgs<GenericDialogueArgs>(
                                  AppRoutes.transferDialog.routeSplitter(),
                                  state.extra,
                                )!,
                              );
                            },
                          );
                        },
                      ),
                      GoRoute(
                        path: AppRoutes.transferSummary.routeSplitter(),
                        pageBuilder: (context, state) {
                          return DialogPage(
                            barrierDismissible: true,
                            useSafeArea: false,
                            barrierColor: Colors.black.withOpacity(0.3),
                            themes: InheritedTheme.capture(
                                from: context, to: context),
                            builder: (_) {
                              return const TransSummarySheet();
                            },
                          );
                        },
                        routes: [
                          GoRoute(
                            path: AppRoutes.transferPin.routeSplitter(),
                            pageBuilder: (context, state) =>
                                CustomPageTransition(
                              widget: TransferPinScreen(
                                args: registerArgs<TransferPinArgs>(
                                  AppRoutes.transferPin.routeSplitter(),
                                  state.extra,
                                )!,
                              ),
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
                path: AppRoutes.savings.routeSplitter(),
                pageBuilder: (context, state) => CustomPageTransition(
                  widget: const SavingsScreen(),
                  direction: AxisDirection.up,
                  pageKey: state.pageKey,
                  durationInMillIs: 300,
                ),
                routes: [
                  GoRoute(
                    path: AppRoutes.savingsPinToTransStatus.routeSplitter(),
                    pageBuilder: (context, state) {
                      return DialogPage(
                        barrierDismissible: true,
                        useSafeArea: false,
                        barrierColor: Colors.black.withOpacity(0.3),
                        themes:
                            InheritedTheme.capture(from: context, to: context),
                        builder: (_) {
                          return GenericDialogueSheet(
                            args: registerArgs<GenericDialogueArgs>(
                              AppRoutes.savingsPinToTransStatus.routeSplitter(),
                              state.extra,
                            )!,
                          );
                        },
                      );
                    },
                  ),
                  GoRoute(
                    path: AppRoutes.savingsToPin.routeSplitter(),
                    pageBuilder: (context, state) => CustomPageTransition(
                      widget: SavingsPinScreen(
                        args: registerArgs<SavingsPinArgs>(
                          AppRoutes.savingsToPin.routeSplitter(),
                          state.extra,
                        )!,
                      ),
                      direction: AxisDirection.up,
                      pageKey: state.pageKey,
                      durationInMillIs: 300,
                    ),
                  ),
                  GoRoute(
                    path: AppRoutes.savingDetails.routeSplitter(),
                    pageBuilder: (context, state) => CustomPageTransition(
                      widget: ReviewSavings(
                        args: registerArgs<ReviewSavingsArgs>(
                          AppRoutes.savingDetails.routeSplitter(),
                          state.extra,
                        )!,
                      ),
                      direction: AxisDirection.up,
                      pageKey: state.pageKey,
                      durationInMillIs: 300,
                    ),
                    routes: [
                      GoRoute(
                        path: AppRoutes.savingDetailsWithdraw.routeSplitter(),
                        pageBuilder: (context, state) => CustomPageTransition(
                          widget: PartialWithdrawalScreen(
                            args: registerArgs<ReviewSavingsArgs>(
                              AppRoutes.savingDetailsWithdraw.routeSplitter(),
                              state.extra,
                            )!,
                          ),
                          direction: AxisDirection.up,
                          pageKey: state.pageKey,
                          durationInMillIs: 300,
                        ),
                        routes: [
                          GoRoute(
                            path: AppRoutes.savingsWithdrawalToPin
                                .routeSplitter(),
                            pageBuilder: (context, state) =>
                                CustomPageTransition(
                              widget: SavingsPinScreen(
                                args: registerArgs<SavingsPinArgs>(
                                  AppRoutes.savingsWithdrawalToPin
                                      .routeSplitter(),
                                  state.extra,
                                )!,
                              ),
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
            ],
          ),
          GoRoute(
            path: AppRoutes.cards,
            builder: (context, state) {
              return const CardScreen();
            },
          ),
          // Loans routes
          GoRoute(
            path: AppRoutes.loans,
            pageBuilder: (context, state) => CustomPageTransition(
              widget: const LoanPage(),
              direction: AxisDirection.left,
              pageKey: state.pageKey,
              durationInMillIs: 300,
            ),
            routes: [
              // add
              GoRoute(
                path: AppRoutes.regSalApp.routeSplitter(),
                pageBuilder: (context, state) => CustomPageTransition(
                  widget: RegSalApp(
                    onSubmit: (formData) {
                      context.pushNamed(
                        AppRoutes.regConApp,
                        extra: formData,
                      );
                    },
                    onClose: () {
                      context.pop();
                    },
                  ),
                  direction: AxisDirection.up,
                  pageKey: state.pageKey,
                  durationInMillIs: 300,
                ),
                routes: [
                  GoRoute(
                    path: AppRoutes.regConApp.routeSplitter(),
                    pageBuilder: (context, state) => CustomPageTransition(
                      widget: RegConApp(
                        formData: state.extra as Map<String, dynamic>? ?? {},
                        onSubmit: (formData) {
                          // Handle form submission
                        },
                      ),
                      direction: AxisDirection.up,
                      pageKey: state.pageKey,
                      durationInMillIs: 300,
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: AppRoutes.easyLoanPin.routeSplitter(),
                pageBuilder: (context, state) {
                  final args = state.extra as EasyLoanPinArgs?;
                  return CustomPageTransition(
                    widget: EasyLoanPin(
                      args: args ?? EasyLoanPinArgs.empty(),
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
              GoRoute(
                path: AppRoutes.loanDetails,
                pageBuilder: (context, state) {
                  final loan = state.extra as Map<String, String>?;
                  return CustomPageTransition(
                    widget: loan == null
                        ? const Scaffold(
                            body: Center(child: Text('No Loan Details Found')),
                          )
                        : LoanDetailsScreen(loan: loan),
                    direction: AxisDirection.up,
                    pageKey: state.pageKey,
                    durationInMillIs: 300,
                  );
                },
              ),
              GoRoute(
                path: AppRoutes.salLoanPin,
                pageBuilder: (context, state) {
                  final args = state.extra as SalLoanPinArgs?;
                  return CustomPageTransition(
                    widget: SalLoanPin(
                      args: args ?? SalLoanPinArgs.empty(),
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

              GoRoute(
                path: AppRoutes.easyLoanDetailsScreen,
                pageBuilder: (context, state) {
                  final loan = state.extra as Map<String, String>?;
                  return CustomPageTransition(
                    widget: loan == null
                        ? const Scaffold(
                            body: Center(child: Text('No Loan Details Found')),
                          )
                        : EasyLoanDetailsScreen(loan: loan),
                    direction: AxisDirection.up,
                    pageKey: state.pageKey,
                    durationInMillIs: 300,
                  );
                },
              ),
              GoRoute(
                path: AppRoutes.easyLoanViewAllPin,
                pageBuilder: (context, state) {
                  final args = state.extra as EasyLoanViewAllPinArgs?;
                  return CustomPageTransition(
                    widget: EasyLoanViewAllPin(
                      args: args ?? EasyLoanViewAllPinArgs.empty(),
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
              GoRoute(
                path: AppRoutes.loanSuccessModal.routeSplitter(),
                pageBuilder: (context, state) {
                  final args = state.extra as LoanSuccessModalArgs?;
                  return CustomPageTransition(
                    widget: LoanSuccessModal(
                      args: args ?? LoanSuccessModalArgs.empty(),
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
              GoRoute(
                path: AppRoutes.loanAppForm,
                pageBuilder: (context, state) => CustomPageTransition(
                  widget: LoanAppForm(
                    onSubmit: (formData) {
                      // Handle form submission
                    },
                    onClose: () {},
                  ),
                  direction: AxisDirection.up,
                  pageKey: state.pageKey,
                  durationInMillIs: 300,
                ),
              ),
              GoRoute(
                path: AppRoutes.loanAppPinloan,
                pageBuilder: (context, state) {
                  final args = state.extra as PinloanArgs?;
                  return CustomPageTransition(
                    widget: Pinloan(
                      args: args ?? PinloanArgs.empty(),
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

          // more routes
          ...moreRoutes,
          // GoRoute(
          //   path: AppRoutes.more,
          //   builder: (context, state) {
          //     // return const SizedBox.shrink();
          //     return const MoreHomePage();
          //   },
          // ),

          // notification route
          // GoRoute(
          //   path: AppRoutes.notificationRoute,
          //   pageBuilder: (context, state) => CustomPageTransition(
          //     widget: const NotifyScreen(),
          //     direction: AxisDirection.up,
          //     pageKey: state.pageKey,
          //     durationInMillIs: 300,
          //   ),
          // ),
        ],
      ),
    ],
  );
}
