import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/features/transfer/transfer.dart';
import 'package:kobo_kobo/functional_util/extensions/extensions.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:provider/provider.dart';

class GenericDialogueArgs {
  final Widget icon;
  final String title;
  final String btn1Title;
  final String btn2Title;
  final Color btn1Color;
  final Color btn2Color;
  final String? onBtn1PressedRoute;
  final String? onBtn2PressedRoute;
  final Object? args;

  GenericDialogueArgs({
    required this.icon,
    required this.title,
    required this.btn1Title,
    required this.btn2Title,
    required this.btn1Color,
    required this.btn2Color,
    required this.onBtn1PressedRoute,
    required this.onBtn2PressedRoute,
    this.args,
  });
}

class GenericDialogueSheet extends StatelessWidget {
  const GenericDialogueSheet({super.key, required this.args});
  final GenericDialogueArgs args;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TransferVm>();
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: AlertDialog(
          alignment: Alignment.bottomCenter,
          insetPadding: EdgeInsets.zero,
          shadowColor: AppColors.black,
          backgroundColor: AppColors.white,
          elevation: 5,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Insets.dim_16),
          ),
          content: SizedBox(
            width: context.getWidth(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                YBox(Insets.dim_30.h),
                Center(
                  child: args.icon,
                ),
                YBox(Insets.dim_34.h),
                Center(
                  child: Text(
                    args.title,
                    textAlign: TextAlign.start,
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.black.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      fontSize: Insets.dim_18.sp,
                    ),
                  ),
                ),
                YBox(Insets.dim_34.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Insets.dim_16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (args.btn1Title.isNotEmpty) ...[
                        Expanded(
                          child: AppOutlineButton(
                            action: () {
                              vm.showBtmSheet = false;
                              vm.showSavingsSheet = false;
                              AppNavigator.of(context).push(
                                args.onBtn1PressedRoute ?? AppRoutes.home,
                                args: args.args,
                              );
                            },
                            textTitle: args.btn1Title,
                          ),
                        ),
                        XBox(Insets.dim_16.w),
                      ],
                      Expanded(
                        child: AppButton(
                          textTitle: args.btn2Title,
                          backgroundColor: args.btn2Color,
                          action: () {
                            vm.showBtmSheet = false;
                            vm.showSavingsSheet = false;
                            AppNavigator.of(context).push(
                                args.onBtn2PressedRoute ?? AppRoutes.home);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                YBox(Insets.dim_40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
