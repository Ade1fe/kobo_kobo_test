import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class DecoratedContainer extends StatelessWidget {
  const DecoratedContainer({
    super.key,
    required this.title,
    required this.amount,
  });

  final String title;
  final num amount;

  @override
  Widget build(BuildContext context) {
    final money = context.money();
    return Container(
      width: context.getWidth(),
      decoration: BoxDecoration(
        borderRadius: Corners.smBorder,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          YBox(Insets.dim_20.h),
          FittedBox(
            child: Text(
              title,
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.black.withOpacity(.5),
                fontSize: Insets.dim_16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          YBox(Insets.dim_10.h),
          Text(
            money.formatWithCurrencySymbol(amount),
            style: context.textTheme.bodySmall!.copyWith(
              color: AppColors.black.withOpacity(0.8),
              fontSize: Insets.dim_18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          YBox(Insets.dim_20.h),
        ],
      ),
    );
  }
}
