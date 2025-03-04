import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/functional_util/assets.dart';
import 'package:kobo_kobo/functional_util/extensions/extensions.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class PinLockScreen extends StatefulWidget {
  const PinLockScreen({super.key});

  @override
  State<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends State<PinLockScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(
        centerTitle: true,
        showLeading: true,
        useSmallFont: true,
        title: '3/3',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Setup your PIN',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.black.withOpacity(.88),
              fontSize: Insets.dim_24.sp,
            ),
            textAlign: TextAlign.start,
          ),
          YBox(Insets.dim_70.h),
          Center(
            child: LocalImage(
              pinLockPng,
              height: context.getHeight(0.15),
            ),
          ),
          YBox(Insets.dim_44.h),
          _pinLockInfo(
              'Fast Login',
              'Access the app quickly without the need to type your username and password every time',
              lightingSvg),
          YBox(Insets.dim_22.h),
          _pinLockInfo('Secure Transactions',
              'Authorize all your transactions with this 4-digit PIN', lockSvg),
          YBox(Insets.dim_22.h),
          _pinLockInfo(
              'Privacy',
              'Enjoy full privacy and comfort knowing only you control access and usage of your account',
              shieldSvg),
          YBox(Insets.dim_22.h),
          const Spacer(),
          AppButton(
            textTitle: 'Setup PIN',
            action: () =>
                AppNavigator.of(context).push(AppRoutes.lockCreatePin),
          ),
          YBox(Insets.dim_34.h),
        ],
      ),
    );
  }

  Widget _pinLockInfo(String title, String description, String icon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Insets.dim_34.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(Insets.dim_6.sp),
            decoration: BoxDecoration(
              color: AppColors.appPrimaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: LocalSvgImage(
              icon,
              height: Insets.dim_24.sp,
            ),
          ),
          XBox(Insets.dim_12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.black,
                    fontSize: Insets.dim_16.sp,
                  ),
                  textAlign: TextAlign.start,
                ),
                YBox(Insets.dim_8.h),
                Text(
                  description,
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withOpacity(.70),
                    fontSize: Insets.dim_12.sp,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
