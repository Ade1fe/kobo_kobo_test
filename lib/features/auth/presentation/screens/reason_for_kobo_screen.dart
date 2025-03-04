import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/functional_util/assets.dart';
import 'package:kobo_kobo/functional_util/extensions/extensions.dart';
import 'package:kobo_kobo/functional_util/log_util.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class ReasonForKoboScreen extends StatefulWidget {
  const ReasonForKoboScreen({super.key});

  @override
  State<ReasonForKoboScreen> createState() => _ReasonForKoboScreenState();
}

class _ReasonForKoboScreenState extends State<ReasonForKoboScreen> {
  late List<ReasonChecker> titles;
  @override
  void initState() {
    super.initState();
    titles = [
      ReasonChecker(title: 'Send and receive money', selected: false),
      ReasonChecker(title: 'Track and manage my spending', selected: false),
      ReasonChecker(title: 'Create and manage my investments', selected: false),
      ReasonChecker(title: 'Save towards my dream', selected: false),
      ReasonChecker(title: 'Access low interest loans', selected: false),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What is your main reason for using KoboKobo?',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.black.withOpacity(.88),
                fontSize: Insets.dim_24.sp,
              ),
            ),
            YBox(Insets.dim_30.h),
            Text(
              'Select all the options that match your preference',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.black.withOpacity(.70),
                fontSize: Insets.dim_14.sp,
              ),
            ),
            YBox(Insets.dim_22.h),
            for (var i = 0; i < titles.length; i++)
              Container(
                margin: EdgeInsets.only(bottom: Insets.dim_18.h),
                padding: EdgeInsets.symmetric(
                    horizontal: Insets.dim_8.w, vertical: Insets.dim_4.h),
                decoration: BoxDecoration(
                  color: AppColors.appPrimaryButton.withOpacity(0.1),
                  borderRadius: Corners.smBorder,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (titles[i].selected)
                      LocalSvgImage(checkedCircleSvg)
                    else
                      LocalSvgImage(circleSvg),
                    XBox(Insets.dim_12.w),
                    Text(
                      titles[i].title,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: Insets.dim_14.sp,
                      ),
                    ),
                  ],
                ),
              ).onTap(() {
                Log().debug('the index is $i');
                setState(() {
                  titles[i].selected = !titles[i].selected;
                });
              }),
            const Spacer(),
            AppButton(
              textTitle: 'Submit',
              action: () => AppNavigator.of(context).push(AppRoutes.login),
            ),
            YBox(Insets.dim_12.h),
            Center(
              child: TextButton(
                onPressed: () => AppNavigator.of(context).push(AppRoutes.login),
                child: Text(
                  'Setup Later',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: Insets.dim_14.sp,
                    color: AppColors.appPrimaryButton,
                  ),
                ),
              ),
            ),
            YBox(Insets.dim_30.h),
          ],
        ),
      ),
    );
  }
}

class ReasonChecker {
  final String title;
  bool selected;

  ReasonChecker({
    required this.title,
    required this.selected,
  });
}
