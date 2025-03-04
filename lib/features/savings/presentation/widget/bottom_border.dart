// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class BottomBorderWidget extends StatelessWidget {
  const BottomBorderWidget({
    super.key,
    required this.title,
    required this.amountVested,
    required this.interest,
    required this.maturityDate,
    required this.status,
    required this.statusColor,
  });

  final String title;
  final num amountVested;
  final num interest;
  final DateTime maturityDate;
  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    final money = context.money();
    return Container(
      width: context.getWidth(),
      padding: EdgeInsets.symmetric(
        vertical: Insets.dim_8.h,
        horizontal: Insets.dim_4.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.appPrimaryButton.withOpacity(0.2),
            width: 2,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPrimaryButton.withOpacity(0.09),
            blurRadius: 4,
            offset: const Offset(0, 5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.black.withOpacity(0.8),
              fontSize: Insets.dim_16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          YBox(Insets.dim_24.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    YBox(Insets.dim_20.h),
                    FittedBox(
                      child: Text(
                        'Amount Invested',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: AppColors.black.withOpacity(.5),
                          fontSize: Insets.dim_16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    YBox(Insets.dim_10.h),
                    Text(
                      money.formatWithCurrencySymbol(amountVested),
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.black.withOpacity(0.8),
                        fontSize: Insets.dim_18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    YBox(Insets.dim_20.h),
                  ],
                ),
              ),
              XBox(Insets.dim_20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    YBox(Insets.dim_20.h),
                    FittedBox(
                      child: Text(
                        'Interest',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: AppColors.black.withOpacity(.5),
                          fontSize: Insets.dim_16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    YBox(Insets.dim_10.h),
                    Text(
                      money.formatWithCurrencySymbol(interest),
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.black.withOpacity(0.8),
                        fontSize: Insets.dim_18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    YBox(Insets.dim_20.h),
                  ],
                ),
              ),
            ],
          ),
          YBox(Insets.dim_20.h),
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'Maturity Date: ',
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.black.withOpacity(0.8),
                      fontSize: Insets.dim_16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: maturityDate.getDate(),
                        style: context.textTheme.bodySmall!.copyWith(
                          color: AppColors.black.withOpacity(0.8),
                          fontSize: Insets.dim_16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              XBox(Insets.dim_20.w),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Insets.dim_16.w,
                  vertical: Insets.dim_2.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: Corners.rsBorder,
                  color: statusColor.withOpacity(0.5),
                ),
                child: FittedBox(
                  child: Text(
                    status,
                    style: context.textTheme.bodySmall!.copyWith(
                      color: statusColor,
                      fontSize: Insets.dim_16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
