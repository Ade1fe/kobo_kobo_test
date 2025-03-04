import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class AccountBalanceBg extends StatelessWidget {
  const AccountBalanceBg({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(
      //   left: Insets.dim_16.w,
      //   right: Insets.dim_16.w,

      // ),
      padding: const EdgeInsets.all(Insets.dim_16),
      decoration: BoxDecoration(
        borderRadius: Corners.mdBorder,
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [-0.3, 0.5],
          colors: [
            Color(0xFFF9A870),
            Color(0xFFFD7322),
          ],
        ),
        image: DecorationImage(
          image: AssetImage(scaffoldTopBottomPng),
          scale: 0.2,
          fit: BoxFit.scaleDown,
          alignment: Alignment.bottomLeft,
        ),
      ),
      child: child,
    );
  }
}

class InAppSourceAccount extends StatelessWidget {
  const InAppSourceAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final money = context.money();
    return AccountBalanceBg(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Individual Account',
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.white,
                      fontSize: Insets.dim_12.sp,
                    ),
                  ),
                  YBox(Insets.dim_6.h),
                  Text(
                    '0034507169',
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.white,
                      fontSize: Insets.dim_16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  XBox(Insets.dim_16.w),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.arrow_drop_down,
                color: AppColors.white,
                size: Insets.dim_40.sp,
              )
            ],
          ),
          YBox(Insets.dim_8.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Balance',
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.white,
                  fontSize: Insets.dim_12.sp,
                ),
              ),
              YBox(Insets.dim_6.h),
              Text(
                money.formatWithCurrencySymbol(
                  12596397,
                  currencyShortName: 'NGN',
                ),
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.white,
                  fontSize: Insets.dim_16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              XBox(Insets.dim_16.w),
            ],
          ),
        ],
      ),
    );
  }
}
