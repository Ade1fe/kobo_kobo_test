import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/core/core.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/features/otp/presentation/screens/otp_screen.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({
    super.key,
  });

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with FormMixin {
  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(
        showLeading: true,
      ),
      body: Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forgot Password',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.black.withOpacity(.88),
                fontSize: Insets.dim_24.sp,
              ),
              textAlign: TextAlign.start,
            ),
            YBox(Insets.dim_14.h),
            Text(
              'Enter your phone number to get a new default password',
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.black.withOpacity(.70),
                fontSize: Insets.dim_14.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
            YBox(Insets.dim_22.h),
            const PhoneNumberTextFormField(),
            const Spacer(),
            AppPrimaryButton(
              textTitle: 'Continue',
              action: () => AppNavigator.of(context).push(
                AppRoutes.forgotPasswordOtp,
                args: OtpScreenArgs(
                  title: '',
                  showLeading: true,
                  useSmallFont: false,
                  centerTitle: false,
                  route: AppRoutes.resetPassword,
                ),
              ),
            ),
            YBox(context.getHeight(0.1.h)),
          ],
        ),
      ),
    );
  }
}
