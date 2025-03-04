import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  bool obscurePassword = true;
  bool obscurePassword2 = true;
  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(
        showLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create New Password',
              style: context.textTheme.titleMedium!.copyWith(
                color: AppColors.black.withOpacity(0.80),
                fontWeight: FontWeight.w400,
                fontSize: Insets.dim_28.sp,
              ),
            ),
            YBox(Insets.dim_24.h),
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
            YBox(Insets.dim_12.h),
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
            YBox(context.getHeight(0.25.h)),
            AppPrimaryButton(
              textTitle: 'Continue',
              action: () => AppNavigator.of(context).push(AppRoutes.login),
            ),
            YBox(Insets.dim_48.h),
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
}
