import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscurePassword = true;
  bool pChecked = false;

  void _pChanged(bool? newValue) => setState(() {
        pChecked = newValue ?? false;
      });
  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Welcome back 👋',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.black.withOpacity(.80),
                  fontSize: Insets.dim_24.sp,
                ),
                children: [
                  TextSpan(
                    text: '\nAdisa Taiwo',
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.black.withOpacity(.60),
                      fontSize: Insets.dim_18.sp,
                    ),
                  ),
                ],
              ),
            ),
            YBox(Insets.dim_30.h),
            Text(
              'Login to continue',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.black.withOpacity(.80),
                fontSize: Insets.dim_16.sp,
              ),
            ),
            YBox(Insets.dim_22.h),
            const PhoneNumberTextFormField(),
            YBox(Insets.dim_12.h),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: checkBoxWidget(
                    context,
                    widget: SizedBox(
                      height: Insets.dim_24.h,
                      width: Insets.dim_24.w,
                      child: Checkbox(
                        onChanged: _pChanged,
                        value: pChecked,
                        shape: const RoundedRectangleBorder(
                          borderRadius: Corners.rsBorder,
                        ),
                        checkColor: AppColors.white,
                        activeColor: AppColors.black,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      AppNavigator.of(context).push(AppRoutes.forgotPassword),
                  child: Text(
                    'Forgot password?',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: Insets.dim_14.sp,
                      color: AppColors.appPrimaryButton,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    textTitle: 'Login',
                    action: () => AppNavigator.of(context).push(AppRoutes.home),
                  ),
                ),
                XBox(Insets.dim_16.w),
                Container(
                  height: Insets.dim_54.h,
                  width: Insets.dim_54.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.black.withOpacity(0.05),
                  ),
                  child: Center(
                    child: LocalSvgImage(faceIdSvg),
                  ),
                ),
              ],
            ),
            YBox(Insets.dim_16.h),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Not Temitope?',
                  children: [
                    TextSpan(
                      text: ' Sign Up',
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.appPrimaryColor,
                        fontSize: Insets.dim_14.sp,
                      ),
                    )
                  ],
                ),
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.black.withOpacity(0.5),
                ),
                textAlign: TextAlign.center,
              ),
            ).onTap(() => AppNavigator.of(context).push(AppRoutes.signUp)),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Contact Us',
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
        XBox(Insets.dim_12.w),
        Expanded(
          child: Text(
            'Remember me ',
            style: context.textTheme.bodySmall!.copyWith(
              color: AppColors.black.withOpacity(0.7),
              fontWeight: FontWeight.w400,
              fontSize: Insets.dim_12.sp,
            ),
          ),
        ),
      ],
    );
  }
}
