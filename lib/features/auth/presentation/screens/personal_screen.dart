import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  bool obscurePassword = true;
  bool obscurePassword2 = true;
  bool pChecked = false;

  void _pChanged(bool? newValue) => setState(() {
        pChecked = newValue ?? false;
      });
  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: CustomAppBar(
        centerTitle: true,
        showLeading: true,
        useSmallFont: true,
        onLeadingPressed: () => AppNavigator.of(context).push(AppRoutes.login),
        title: '1/3',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: context.textTheme.titleMedium!.copyWith(
                color: AppColors.black.withOpacity(0.80),
                fontWeight: FontWeight.w400,
                fontSize: Insets.dim_28.sp,
              ),
            ),
            YBox(Insets.dim_24.h),
            const AppTextFormField(
              labelText: 'National Identification Number (NIN)',
              hintText: 'Enter your 11 digits NIN',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.dim_16.w),
              child: Text(
                'Adeyemi Temitope',
                style: context.textTheme.titleMedium!.copyWith(
                  color: AppColors.appPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  fontSize: Insets.dim_12.sp,
                  decorationStyle: TextDecorationStyle.wavy,
                ),
              ),
            ),
            YBox(Insets.dim_10.h),
            const PhoneNumberTextFormField(),
            YBox(Insets.dim_12.h),
            AppTextFormField(
              labelText: 'Email Address ',
              hintText: 'Enter your email address',
              validator: (email) => Validators.validateEmail(value: email),
            ),
            YBox(Insets.dim_12.h),
            const AppTextFormField(
              labelText: 'Referral Code (optional) ',
              hintText: 'Enter your referral code',
              obscureText: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.dim_16.w),
              child: Text(
                'Adeyemi Temitope',
                style: context.textTheme.titleMedium!.copyWith(
                  color: AppColors.appPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  fontSize: Insets.dim_12.sp,
                  decorationStyle: TextDecorationStyle.wavy,
                ),
              ),
            ),
            YBox(Insets.dim_10.h),
            AppTextFormField(
              labelText: 'Password',
              hintText: 'Enter your password',
              validator: (password) => Validators.validatePassword()(password),
              suffixIcon: _obscurePassword(obscurePassword).onTap(
                () => setState(() => obscurePassword = !obscurePassword),
              ),
              obscureText: obscurePassword,
            ),
            YBox(Insets.dim_12.h),
            AppTextFormField(
              labelText: 'Confirm Password',
              hintText: 'Confirm your password',
              validator: (password) => Validators.validatePassword()(password),
              suffixIcon: _obscurePassword(obscurePassword2).onTap(
                () => setState(() => obscurePassword2 = !obscurePassword2),
              ),
              obscureText: obscurePassword2,
            ),
            YBox(Insets.dim_28.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                XBox(Insets.dim_4.w),
                Icon(
                  PhosphorIcons.warningCircle(PhosphorIconsStyle.fill),
                  color: AppColors.black.withOpacity(0.7),
                  size: Insets.dim_16.w,
                ),
                XBox(Insets.dim_8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your password should contain at least: ',
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                        fontSize: Insets.dim_12.sp,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                    YBox(Insets.dim_18.h),
                    _bullets(context, '8 character letters,'),
                    _bullets(context, 'an uppercase,'),
                    _bullets(context, 'a lowercase,'),
                    _bullets(context, 'a special character'),
                    _bullets(context, 'a number'),
                  ],
                )
              ],
            ),
            YBox(Insets.dim_30.h),
            checkBoxWidget(
              context,
              widget: Checkbox(
                onChanged: _pChanged,
                value: pChecked,
                shape: const RoundedRectangleBorder(
                  borderRadius: Corners.rsBorder,
                ),
                checkColor: AppColors.white,
                activeColor: AppColors.black,
              ),
            ),
            YBox(Insets.dim_12.h),
            AppPrimaryButton(
              textTitle: 'Continue',
              action: () => AppNavigator.of(context).push(AppRoutes.signUpOtp),
            ),
            YBox(Insets.dim_48.h),
          ],
        ),
      ),
    );
  }

  Widget _bullets(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: Insets.dim_4.h,
          width: Insets.dim_4.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.black.withValues(alpha: 0.6),
          ),
        ),
        XBox(Insets.dim_8.w),
        Text(
          title,
          style: context.textTheme.bodySmall!.copyWith(
            color: AppColors.black.withValues(alpha: 0.6),
            fontWeight: FontWeight.w500,
            fontSize: Insets.dim_12.sp,
            decorationStyle: TextDecorationStyle.wavy,
          ),
        ),
      ],
    );
  }

  Widget _obscurePassword(bool obscureP) {
    return Icon(
      obscureP ? PhosphorIcons.eyeSlash() : PhosphorIcons.eye(),
      color: AppColors.black,
    );
  }

  Widget checkBoxWidget(
    BuildContext context, {
    required Widget widget,
  }) {
    return Row(
      children: [
        widget,
        Expanded(
          child: Text(
            'I accept the Terms, Conditions and Privacy Policy of KoboKobo ',
            style: context.textTheme.bodySmall!.copyWith(
              color: AppColors.black.withOpacity(0.8),
              fontWeight: FontWeight.w400,
              fontSize: Insets.dim_12.sp,
            ),
          ),
        ),
      ],
    );
  }
}
