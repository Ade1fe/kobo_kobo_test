import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class LoanOverlayScreen extends StatelessWidget {
  final bool isLoading;
  final bool? isEligible;
  final VoidCallback onGoBack;

  const LoanOverlayScreen({
    super.key,
    required this.isLoading,
    required this.isEligible,
    required this.onGoBack,
  });

//   @override
//   Widget build(BuildContext context) {
//     return AppScaffoldWidget(
//       body: LoanOverlay(
//         isLoading: isLoading,
//         isEligible: isEligible,
//         onGoBack: onGoBack,
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return LoanOverlay(
      isLoading: isLoading,
      isEligible: isEligible,
      onGoBack: onGoBack,
    );
  }
}

class LoanOverlay extends StatelessWidget {
  final bool isLoading;
  final bool? isEligible;
  final VoidCallback onGoBack;

  const LoanOverlay({
    super.key,
    required this.isLoading,
    required this.isEligible,
    required this.onGoBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      body: Container(
          color: Colors.white,
          child: Center(
            child: isLoading
                ? _buildLoadingIndicator(context)
                : _buildEligibilityResult(context),
          )),
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularDotsLoader(
          color: AppColors.appPrimaryButton,
          size: 100.w,
        ),
        SizedBox(height: 24.h),
        Padding(
          padding: EdgeInsets.all(0.w),
          child: Text(
            "Please wait a moment while the system checks your eligibility...",
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall!.copyWith(
              fontSize: Insets.dim_18.sp,
              color: AppColors.black.withValues(alpha: 0.8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEligibilityResult(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Loan',
            style: TextStyle(
              fontSize: Insets.dim_24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 24.h),
                Center(
                  child: LocalImage(
                    sadFaceImg,
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
                Text(
                  "We are sorry! You are not eligible at the moment. Keep receiving your salary with Kobokobo to qualify.",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall!.copyWith(
                    fontSize: Insets.dim_18.sp,
                    color: AppColors.black.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(0.w),
            child: AppButton(
              textTitle: "Go Back",
              action: onGoBack,
            ),
          ),
          YBox(Insets.dim_40.h),
        ],
      ),
    );
  }
}
