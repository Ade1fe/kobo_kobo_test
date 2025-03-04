import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:flutter/material.dart';

class WelcomeStep extends StatelessWidget {
  const WelcomeStep({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });
  final String image;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: LocalImage(
            image,
            height: context.getHeight(0.75),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Text(
                title,
                style: context.textTheme.headlineLarge!.copyWith(
                  fontSize: Insets.dim_24.sp,
                  height: 1.3,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const YBox(Insets.dim_8),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Text(
                description,
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.textBodyColor,
                  fontWeight: FontWeight.w400,
                  fontSize: Insets.dim_16.sp,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const YBox(
              Insets.dim_173,
            ),
          ],
        ),
      ],
    );
  }
}
