import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kobo_kobo/core/core.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/features/otp/otp.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class OtpScreenArgs {
  final String title;
  final bool showLeading;
  final bool useSmallFont;
  final bool centerTitle;
  final String? route;

  OtpScreenArgs({
    required this.title,
    required this.showLeading,
    required this.useSmallFont,
    required this.centerTitle,
    this.route,
  });
}

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    super.key,
    required this.args,
  });
  final OtpScreenArgs args;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with FormMixin, OtpTimeoutMixin {
  final _otpTEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: CustomAppBar(
        centerTitle: widget.args.centerTitle,
        showLeading: widget.args.showLeading,
        useSmallFont: widget.args.useSmallFont,
        title: widget.args.title,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: formKey,
              autovalidateMode: autoValidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter your OTP',
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.black.withOpacity(.88),
                      fontSize: Insets.dim_24.sp,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  YBox(Insets.dim_14.h),
                  Text.rich(
                    TextSpan(
                      text:
                          'Please enter the OTP sent to your phone number: \n',
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.black.withOpacity(.70),
                        fontSize: Insets.dim_14.sp,
                        fontWeight: FontWeight.w400,
                        height: 3,
                      ),
                      children: [
                        TextSpan(
                          text: '+2348066119024',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: AppColors.black,
                            fontSize: Insets.dim_16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  YBox(Insets.dim_20.h),
                  Text(
                    'Edit Phone Number',
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.black.withOpacity(.70),
                      fontSize: Insets.dim_14.sp,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.black,
                    ),
                    textAlign: TextAlign.start,
                  ).onTap(() {
                    //
                  }),
                  YBox(Insets.dim_54.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Insets.dim_48.w),
                    child: PinTextField(
                      onChanged: (input) {},
                      controller: _otpTEC,
                      validator: (input) => Validators.validateOtp()(input),
                    ),
                  ),
                  YBox(Insets.dim_80.h),
                  AppPrimaryButton(
                    textTitle: 'Verify OTP',
                    action: () => context
                        .push(widget.args.route ?? AppRoutes.signUpOtpCountry),
                  ),
                  YBox(Insets.dim_22.h),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: getCurrentOtpTimeoutCount(
                          isTimerExpired: isTimerExpired,
                        ),
                        style: context.textTheme.bodySmall!.copyWith(
                          color: AppColors.black.withOpacity(.70),
                          fontSize: Insets.dim_14.sp,
                        ),
                        children: [
                          TextSpan(
                            text: 'Resend OTP',
                            style: context.textTheme.bodySmall!.copyWith(
                              color: AppColors.appPrimaryColor,
                              fontSize: Insets.dim_14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).onTap(() {
                    if (isTimerExpired) {
                      resetTimer(2);
                      _otpTEC.clear();
                    }
                  }),
                  YBox(context.getHeight(0.2)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
