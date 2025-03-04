import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:flutter/material.dart';

class InfoBottomSheet extends StatelessWidget {
  const InfoBottomSheet({
    required this.heading,
    required this.content,
    required this.buttonLabel,
    required this.onPressed,
    super.key,
  });

  final String heading;
  final String content;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.cancel_outlined,
                  color: AppColors.black.withOpacity(.88),
                  size: 24,
                ),
              ),
            ),
            const YBox(Insets.dim_20),
            Text(
              heading,
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: Insets.dim_32.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            const YBox(Insets.dim_4),
            Text(
              content,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: Insets.dim_14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.black.withOpacity(.65),
              ),
            ),
            const YBox(Insets.dim_40),
            AppButton(
              textTitle: buttonLabel,
              action: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
