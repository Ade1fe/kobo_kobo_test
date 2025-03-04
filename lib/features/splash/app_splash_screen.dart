import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(3.seconds, () async {
        if (mounted) {
          AppNavigator.of(context).push(AppRoutes.onboarding);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: LocalImage(
              scaffoldTopBottomPng,
              height: Insets.dim_200.h,
              color: AppColors.appPrimaryButton.withValues(alpha: 0.8),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LocalImage(
                  appPngLogo,
                  height: Insets.dim_173.h,
                ),
                Center(
                  child: SizedBox(
                    width: context.getWidth(0.5),
                    child: Text(
                      'Your Sure Partner to Financial Freedom',
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall!.copyWith(
                        fontSize: Insets.dim_18.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.appPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: LocalImage(
              scaffoldTopBottomPng,
              height: Insets.dim_200.h,
              color: AppColors.appPrimaryButton.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
