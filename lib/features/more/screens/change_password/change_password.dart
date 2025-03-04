import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/functional_util/extensions/context_extension.dart';
import 'package:kobo_kobo/functional_util/validators.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../ui_widgets/ui_widgets.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool obscureOldPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  String? error;

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(showLeading: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Change Password',
                  style: context.textTheme.bodySmall!.copyWith(
                    fontSize: Insets.dim_24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 14.h),
                const Divider(height: 1, thickness: 1.0),
                SizedBox(height: 22.h),
                Align(
                    child: Text(
                  'Enter your old and new password below',
                  // style: TextStyle(fontSize: 16.sp),
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontSize: Insets.dim_16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black.withOpacity(0.8),
                  ),
                )),
                SizedBox(height: 52.h),
                // Old Password field
                AppTextFormField(
                  controller: oldPasswordController,
                  labelText: 'Old Password',
                  hintText: 'Enter your old password',
                  validator: (password) =>
                      Validators.validatePassword()(password),
                  suffixIcon: GestureDetector(
                    onTap: () => setState(
                      () => obscureOldPassword = !obscureOldPassword,
                    ),
                    child: _obscurePassword(obscureOldPassword),
                  ),
                  obscureText: obscureOldPassword,
                ),
                SizedBox(height: Insets.dim_12.h),
                // New Password field
                AppTextFormField(
                  controller: newPasswordController,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  validator: (password) =>
                      Validators.validatePassword()(password),
                  suffixIcon: GestureDetector(
                    onTap: () => setState(
                      () => obscureNewPassword = !obscureNewPassword,
                    ),
                    child: _obscurePassword(obscureNewPassword),
                  ),
                  obscureText: obscureNewPassword,
                ),
                SizedBox(height: Insets.dim_12.h),
                // Confirm Password field with mismatch check
                AppTextFormField(
                  controller: confirmPasswordController,
                  labelText: 'Confirm Password',
                  hintText: 'Confirm your password',
                  validator: (password) {
                    if (password != newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return Validators.validatePassword()(password);
                  },
                  suffixIcon: GestureDetector(
                    onTap: () => setState(
                      () => obscureConfirmPassword = !obscureConfirmPassword,
                    ),
                    child: _obscurePassword(obscureConfirmPassword),
                  ),
                  obscureText: obscureConfirmPassword,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: error != null
                        ? Text(
                            error!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.red[700],
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
                SizedBox(height: Insets.dim_12.h),
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
                YBox(context.getHeight(0.1.h)),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: AppPrimaryButton(
                    action: () {
                      if (newPasswordController.text ==
                          confirmPasswordController.text) {
                        // Placeholder for actual password change logic
                        showTopSnackBar(context, 'Password Change Successful');
                      } else {
                        setState(() {
                          error = 'Passwords do not match';
                        });
                      }
                    },
                    textTitle: 'Send',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for the eye icon toggle
  Widget _obscurePassword(bool obscureP) {
    return Icon(
      obscureP ? PhosphorIcons.eyeSlash() : PhosphorIcons.eye(),
      color: AppColors.black,
    );
  }

  // A helper widget to display small bullet points (used elsewhere in the UI)
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
        SizedBox(width: Insets.dim_8.w),
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

  // Custom top snack bar to show success message
  void showTopSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0,
        left: 0.0,
        right: 0.0,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      PhosphorIcons.checkCircle(),
                      size: 24.sp,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      // overlayEntry.remove();
                    },
                  ),
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      PhosphorIcons.xCircle(),
                      size: 24.sp,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      // overlayEntry.remove();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
