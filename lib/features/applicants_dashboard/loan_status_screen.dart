import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class LoanStatusScreen extends StatelessWidget {
  final String title;
  final String imagePath;
  final String message;
  final String primaryButtonText;
  final VoidCallback primaryAction;
  final String? secondaryButtonText;
  final VoidCallback? secondaryAction;

  const LoanStatusScreen({
    required this.title,
    required this.imagePath,
    required this.message,
    required this.primaryButtonText,
    required this.primaryAction,
    this.secondaryButtonText,
    this.secondaryAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(showLeading: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Image.asset(imagePath, height: 200, width: 200),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: Insets.dim_16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Spacer(),
          AppPrimaryButton(
            action: primaryAction,
            textTitle: primaryButtonText,
          ),
          if (secondaryButtonText != null)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: AppOutlineButton(
                action: () => {secondaryAction},
                textTitle: secondaryButtonText!,
              ),
            ),
          // const SizedBox(height: 20),
          const YBox(70),
        ],
      ),
    );
  }
}
