// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:kobo_kobo/features/navigation/navigation.dart';

// // import '../../../../loans/loans.dart';

// // List<GoRoute> loanRoutes = [
// //   GoRoute(
// //     path: AppRoutes.loans,
// //     pageBuilder: (context, state) => CustomPageTransition(
// //       widget: const LoanPage(),
// //       direction: AxisDirection.up,
// //       pageKey: state.pageKey,
// //       durationInMillIs: 300,
// //     ),
// //     routes: [
// //       GoRoute(
// //         path: AppRoutes.loanDetails,
// //         pageBuilder: (context, state) {
// //           final loan = state.extra as Map<String, String>?;
// //           return CustomPageTransition(
// //             widget: loan != null
// //                 ? LoanDetailsScreen(loan: loan)
// //                 : const Scaffold(
// //                     body: Center(child: Text('No Loan Details Found')),
// //                   ),
// //             direction: AxisDirection.up,
// //             pageKey: state.pageKey,
// //             durationInMillIs: 300,
// //           );
// //         },
// //       ),
// //       GoRoute(
// //         path: AppRoutes.salLoanPin, // Relative path
// //         pageBuilder: (context, state) {
// //           final args = state.extra as SalLoanPinArgs?;
// //           return CustomPageTransition(
// //             widget: SalLoanPin(
// //               args: args ?? SalLoanPinArgs.empty(),
// //               onPinEntered: (pin) {
// //                 print('PIN entered: $pin');
// //               },
// //             ),
// //             direction: AxisDirection.up,
// //             pageKey: state.pageKey,
// //             durationInMillIs: 300,
// //           );
// //         },
// //       ),
// //       GoRoute(
// //         path: AppRoutes.regSalApp,
// //         pageBuilder: (context, state) => CustomPageTransition(
// //           widget: RegSalApp(
// //             onSubmit: (formData) {
// //               context.pushNamed(AppRoutes.regConApp, extra: formData);
// //             },
// //             onClose: () {
// //               context.pop();
// //             },
// //           ),
// //           direction: AxisDirection.up,
// //           pageKey: state.pageKey,
// //           durationInMillIs: 300,
// //         ),
// //       ),
// //       GoRoute(
// //         name: AppRoutes.regConApp,
// //         path: AppRoutes.regConApp,
// //         pageBuilder: (context, state) => CustomPageTransition(
// //           widget: RegConApp(
// //             formData: state.extra as Map<String, dynamic>? ?? {},
// //             onSubmit: (formData) {
// //               // Handle form submission
// //             },
// //           ),
// //           direction: AxisDirection.up,
// //           pageKey: state.pageKey,
// //           durationInMillIs: 300,
// //         ),
// //       ),
// //       GoRoute(
// //         path: AppRoutes.easyLoanPin,
// //         pageBuilder: (context, state) {
// //           final args = state.extra as EasyLoanPinArgs?;
// //           return CustomPageTransition(
// //             widget: EasyLoanPin(
// //               args: args ?? EasyLoanPinArgs.empty(),
// //               onPinEntered: (pin) {
// //                 print('PIN entered: $pin');
// //               },
// //             ),
// //             direction: AxisDirection.up,
// //             pageKey: state.pageKey,
// //             durationInMillIs: 300,
// //           );
// //         },
// //       ),
// //       GoRoute(
// //         path: AppRoutes.easyLoanDetailsScreen,
// //         builder: (context, state) {
// //           final loan = state.extra as Map<String, String>?;
// //           if (loan == null) {
// //             return const Scaffold(
// //               body: Center(child: Text('No Loan Details Found')),
// //             );
// //           }
// //           return EasyLoanDetailsScreen(loan: loan);
// //         },
// //       ),
// //       GoRoute(
// //         path: AppRoutes.easyLoanViewAllPin,
// //         pageBuilder: (context, state) {
// //           final args = state.extra as EasyLoanViewAllPinArgs?;
// //           return CustomPageTransition(
// //             widget: EasyLoanViewAllPin(
// //               args: args ?? EasyLoanViewAllPinArgs.empty(),
// //               onPinEntered: (pin) {
// //                 print('PIN entered: $pin');
// //               },
// //             ),
// //             direction: AxisDirection.up,
// //             pageKey: state.pageKey,
// //             durationInMillIs: 300,
// //           );
// //         },
// //       ),
// //       GoRoute(
// //         path: AppRoutes.loanAppForm,
// //         pageBuilder: (context, state) => CustomPageTransition(
// //           widget: LoanAppForm(
// //             onSubmit: (formData) {
// //               // Handle form submission
// //             },
// //             onClose: () {},
// //           ),
// //           direction: AxisDirection.up,
// //           pageKey: state.pageKey,
// //           durationInMillIs: 300,
// //         ),
// //       ),
// //       GoRoute(
// //         path: AppRoutes.loanAppPinloan,
// //         pageBuilder: (context, state) {
// //           final args = state.extra as PinloanArgs?;
// //           return CustomPageTransition(
// //             widget: Pinloan(
// //               args: args ?? PinloanArgs.empty(),
// //               onPinEntered: (pin) {
// //                 print('PIN entered: $pin');
// //               },
// //             ),
// //             direction: AxisDirection.up,
// //             pageKey: state.pageKey,
// //             durationInMillIs: 300,
// //           );
// //         },
// //       ),
// //     ],
// //   ),
// // ];

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:kobo_kobo/features/navigation/navigation.dart';
// import 'package:kobo_kobo/functional_util/extensions/string.dart';

// import '../../../../loans/loans.dart';

// List<GoRoute> loanRoutes = [
//   GoRoute(
//     path: AppRoutes.loans,
//     pageBuilder: (context, state) => CustomPageTransition(
//       widget: const LoanPage(),
//       direction: AxisDirection.up,
//       pageKey: state.pageKey,
//       durationInMillIs: 300,
//     ),
//     routes: [
//       GoRoute(
//         path: AppRoutes.loanDetails.routeSplitter(),
//         pageBuilder: (context, state) {
//           final loan = state.extra as Map<String, String>?;
//           return CustomPageTransition(
//             widget: loan != null
//                 ? LoanDetailsScreen(loan: loan)
//                 : const Scaffold(
//                     body: Center(child: Text('No Loan Details Found')),
//                   ),
//             direction: AxisDirection.up,
//             pageKey: state.pageKey,
//             durationInMillIs: 300,
//           );
//         },
//       ),
//       GoRoute(
//         path: AppRoutes.salLoanPin.routeSplitter(),
//         pageBuilder: (context, state) => CustomPageTransition(
//           widget: SalLoanPin(
//             args: const SalLoanPinArgs(
//               // state.extra,
//               routeTo: '', // or specify a route if needed
//             ),
//             onPinEntered: (pin) {
//               print('PIN entered: $pin');
//             },
//           ),
//           direction: AxisDirection.up,
//           pageKey: state.pageKey,
//           durationInMillIs: 300,
//         ),
//       ),
//       GoRoute(
//         path: AppRoutes.regSalApp.routeSplitter(),
//         pageBuilder: (context, state) => CustomPageTransition(
//           widget: RegSalApp(
//             onSubmit: (formData) {
//               context.pushNamed(AppRoutes.regConApp, extra: formData);
//             },
//             onClose: () {
//               context.pop();
//             },
//           ),
//           direction: AxisDirection.up,
//           pageKey: state.pageKey,
//           durationInMillIs: 300,
//         ),
//       ),
//       GoRoute(
//         name: AppRoutes.regConApp,
//         path: AppRoutes.regConApp.routeSplitter(),
//         pageBuilder: (context, state) => CustomPageTransition(
//           widget: RegConApp(
//             formData: state.extra as Map<String, dynamic>? ?? {},
//             onSubmit: (formData) {
//               // Handle form submission
//             },
//           ),
//           direction: AxisDirection.up,
//           pageKey: state.pageKey,
//           durationInMillIs: 300,
//         ),
//       ),
//       GoRoute(
//         path: AppRoutes.easyLoanPin.routeSplitter(),
//         pageBuilder: (context, state) {
//           final args = state.extra as EasyLoanPinArgs?;
//           return CustomPageTransition(
//             widget: EasyLoanPin(
//               args: args ?? EasyLoanPinArgs.empty(),
//               onPinEntered: (pin) {
//                 print('PIN entered: $pin');
//               },
//             ),
//             direction: AxisDirection.up,
//             pageKey: state.pageKey,
//             durationInMillIs: 300,
//           );
//         },
//       ),
//       GoRoute(
//         path: AppRoutes.easyLoanDetailsScreen.routeSplitter(),
//         builder: (context, state) {
//           final loan = state.extra as Map<String, String>?;
//           if (loan == null) {
//             return const Scaffold(
//               body: Center(child: Text('No Loan Details Found')),
//             );
//           }
//           return EasyLoanDetailsScreen(loan: loan);
//         },
//       ),
//       GoRoute(
//         path: AppRoutes.easyLoanViewAllPin.routeSplitter(),
//         pageBuilder: (context, state) {
//           final args = state.extra as EasyLoanViewAllPinArgs?;
//           return CustomPageTransition(
//             widget: EasyLoanViewAllPin(
//               args: args ?? EasyLoanViewAllPinArgs.empty(),
//               onPinEntered: (pin) {
//                 print('PIN entered: $pin');
//               },
//             ),
//             direction: AxisDirection.up,
//             pageKey: state.pageKey,
//             durationInMillIs: 300,
//           );
//         },
//       ),
//       GoRoute(
//         path: AppRoutes.loanSuccessModal.routeSplitter(),
//         pageBuilder: (context, state) {
//           final args = state.extra as LoanSuccessModalArgs?;
//           return CustomPageTransition(
//             widget: LoanSuccessModal(
//               args: args ?? LoanSuccessModalArgs.empty(),
//               onPinEntered: (pin) {
//                 print('PIN entered: $pin');
//               },
//             ),
//             direction: AxisDirection.up,
//             pageKey: state.pageKey,
//             durationInMillIs: 300,
//           );
//         },
//       ),
//       GoRoute(
//         path: AppRoutes.loanAppForm.routeSplitter(),
//         pageBuilder: (context, state) => CustomPageTransition(
//           widget: LoanAppForm(
//             onSubmit: (formData) {
//               // Handle form submission
//             },
//             onClose: () {},
//           ),
//           direction: AxisDirection.up,
//           pageKey: state.pageKey,
//           durationInMillIs: 300,
//         ),
//       ),
//       GoRoute(
//         path: AppRoutes.loanAppPinloan.routeSplitter(),
//         pageBuilder: (context, state) {
//           final args = state.extra as PinloanArgs?;
//           return CustomPageTransition(
//             widget: Pinloan(
//               args: args ?? PinloanArgs.empty(),
//               onPinEntered: (pin) {
//                 print('PIN entered: $pin');
//               },
//             ),
//             direction: AxisDirection.up,
//             pageKey: state.pageKey,
//             durationInMillIs: 300,
//           );
//         },
//       ),
//     ],
//   ),
// ];
