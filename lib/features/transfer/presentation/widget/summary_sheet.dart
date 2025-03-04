import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/features/transfer/transfer.dart';
import 'package:kobo_kobo/functional_util/extensions/extensions.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class TransSummarySheet extends StatelessWidget {
  const TransSummarySheet({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransferVm>();

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
                YBox(Insets.dim_16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Insets.dim_16.w),
                      child: Icon(
                        PhosphorIcons.x(PhosphorIconsStyle.bold),
                        color: AppColors.borderErrorColor,
                        size: Insets.dim_26.sp,
                      ),
                    ).onTap(() => AppNavigator.of(context).popDialog()),
                    const Spacer(),
                    Text(
                      'Transfer Summary',
                      textAlign: TextAlign.start,
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                        fontSize: Insets.dim_18.sp,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: Insets.dim_32.w,
                      height: Insets.dim_4.h,
                    ),
                  ],
                ),
                YBox(Insets.dim_34.h),
                SizedBox(
                  height: context.getHeight(0.35.h),
                  child: ListView.builder(
                    itemCount: provider.koboAccount
                        ? provider.items2.length
                        : provider.items3.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = provider.koboAccount
                          ? provider.items2[index]
                          : provider.items3[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Insets.dim_16.w,
                          vertical: Insets.dim_16.h,
                        ),
                        child: Row(
                          children: [
                            Text(
                              item.title,
                              textAlign: TextAlign.start,
                              style: context.textTheme.bodySmall!.copyWith(
                                color: AppColors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w400,
                                fontSize: Insets.dim_14.sp,
                              ),
                            ),
                            const Spacer(),
                            if (item.title.toLowerCase().contains('amount'))
                              Text(
                                context.money().formatWithCurrencySymbol(
                                    double.tryParse(item.subtitle ?? '0')!),
                                textAlign: TextAlign.start,
                                style: context.textTheme.bodySmall!.copyWith(
                                  color: AppColors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                  fontSize: Insets.dim_18.sp,
                                ),
                              )
                            else
                              Text(
                                item.subtitle ?? '',
                                textAlign: TextAlign.start,
                                style: context.textTheme.bodySmall!.copyWith(
                                  color: AppColors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                  fontSize: Insets.dim_18.sp,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                YBox(Insets.dim_40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Insets.dim_16.w),
                  child: AppButton(
                    textTitle: 'Continue',
                    action: () => AppNavigator.of(context).push(
                      provider.koboAccount
                          ? AppRoutes.transferPin
                          : AppRoutes.bankTransferSummaryPin,
                      args: TransferPinArgs(
                        route: provider.koboAccount
                            ? AppRoutes.koboTransfer
                            : AppRoutes.bankTransfer,
                        extra: BankOrKoboAccountTransferArgs(
                          koboAccount: provider.koboAccount,
                        ),
                      ),
                    ),
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
