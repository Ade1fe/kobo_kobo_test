import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/features/onboarding/onboarding.dart';
import 'package:kobo_kobo/functional_util/assets.dart';
import 'package:kobo_kobo/functional_util/extensions/extensions.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<OnboardingVm>().initiate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingVm>(
      builder: (_, provider, __) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: Insets.dim_32),
            height: context.getHeight(),
            child: Column(
              children: [
                YBox(Insets.dim_24.h),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: provider.currentValue == 2
                        ? const SizedBox.shrink()
                        : Text(
                            'Skip',
                            style: context.textTheme.bodySmall!.copyWith(
                              color: AppColors.appPrimaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: Insets.dim_14.sp,
                            ),
                          ).onTap(() {
                            provider.cancelTimer();
                          }),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: provider.welcomePageController,
                    onPageChanged: provider.changeCurrentValue,
                    children: List.generate(
                      3,
                      (index) {
                        final images = [
                          onb1,
                          onb2,
                          onb3,
                        ];
                        final title = [
                          'Savings Made Easy!',
                          'High Returns, Zero Hassle!',
                          'Borrow Smart, Pay Less!',
                        ];
                        final description = [
                          'Unleash your potential with a Savings Plan that suits you.',
                          'Create, monitor and liquidate high yield investments on the go.',
                          'Be limitless! Access low interest loans anytime.',
                        ];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            YBox(Insets.dim_173.h),
                            LocalImage(
                              images[index],
                              height: context.getHeight(0.4).h,
                              fit: BoxFit.scaleDown,
                            ),
                            YBox(Insets.dim_14.h),
                            AutoSizeText(
                              title[index],
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: context.textTheme.titleMedium!.copyWith(
                                color: AppColors.black.withOpacity(0.80),
                                fontSize: Insets.dim_28.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            YBox(Insets.dim_8.h),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Insets.dim_20.w),
                                child: AutoSizeText(
                                  description[index],
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color: AppColors.black.withOpacity(0.50),
                                    fontSize: Insets.dim_20.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                if (provider.currentValue == 2) ...[
                  YBox(Insets.dim_12.h),
                  AppPrimaryButton(
                    textTitle: 'Create Account',
                    action: () {
                      AppNavigator.of(context).push(AppRoutes.signUp);
                    },
                  ),
                  const YBox(Insets.dim_12),
                  AppOutlineButton(
                    action: () =>
                        AppNavigator.of(context).push(AppRoutes.login),
                    textTitle: 'Login ',
                  ),
                ],
                YBox(Insets.dim_20.h),
                SmoothPageIndicator(
                  controller: provider.welcomePageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    expansionFactor: 2.5,
                    dotHeight: 8.w,
                    dotWidth: 22.w,
                    activeDotColor: AppColors.appPrimaryColor,
                    dotColor: AppColors.black.withOpacity(0.3),
                  ),
                ),
                YBox(Insets.dim_24.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
