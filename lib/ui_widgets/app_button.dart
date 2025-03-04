import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:flutter/material.dart';

class AppGreyButton extends AppButton {
  const AppGreyButton({
    required super.textTitle,
    required super.action,
    super.fullWidth,
    super.deActivate,
    bool super.showLoading = false,
    super.key,
  }) : super(
          color: AppColors.white,
          backgroundColor: AppColors.btnSecondaryColor,
        );
}

class AppOutlineButton extends AppButton {
  const AppOutlineButton({
    required super.textTitle,
    required super.action,
    super.deActivate,
    super.key,
    super.fullWidth,
    bool super.showLoading = false,
    super.child,
    super.isOutlined = true,
  }) : super(
          color: AppColors.white,
          loadingColor: AppColors.appPrimaryColor,
          backgroundColor: Colors.white,
        );
}

class AppPrimaryButton extends AppButton {
  const AppPrimaryButton({
    required super.textTitle,
    required super.action,
    super.deActivate,
    super.key,
    super.fullWidth,
    bool super.showLoading = false,
    super.child,
  }) : super(
          color: AppColors.white,
          backgroundColor: AppColors.appPrimaryButton,
        );
}

class AppButton extends StatelessWidget {
  const AppButton({
    required this.textTitle,
    required this.action,
    this.deActivate,
    super.key,
    this.fullWidth = true,
    this.showLoading,
    this.color,
    this.backgroundColor,
    this.loadingColor,
    this.child,
    this.isOutlined = false,
  });
  final String textTitle;
  final bool fullWidth;
  final bool? showLoading;
  final bool? deActivate;
  final Color? color, backgroundColor, loadingColor;
  final VoidCallback action;
  final Widget? child;
  final bool? isOutlined;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Insets.dim_50.h,
        width: fullWidth ? context.getWidth(0.9.w) : null,
        child: ElevatedButton(
          key: key,
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Insets.dim_8.sp),
                    side: BorderSide(
                      color: isOutlined == true
                          ? AppColors.appPrimaryColor
                          : deActivate == true
                              ? AppColors.borderColor
                              : backgroundColor ?? AppColors.white,
                      width: 1.5,
                    ),
                  ),
                ),
                backgroundColor: deActivate == true
                    ? WidgetStateProperty.all<Color>(Colors.grey.shade300)
                    : backgroundColor != null
                        ? WidgetStateProperty.all<Color>(backgroundColor!)
                        : WidgetStateProperty.all<Color>(
                            AppColors.appPrimaryColor,
                          ),
              ),
          onPressed: showLoading == true || deActivate == true ? null : action,
          child: showLoading == true
              ? AppLoadingWidget(
                  color: backgroundColor != null ? Colors.white : loadingColor,
                )
              : child ??
                  Text(
                    textTitle,
                    style: context.textTheme.bodySmall!.copyWith(
                      color: deActivate == true
                          ? Colors.grey.shade400
                          : isOutlined == true
                              ? AppColors.appPrimaryColor
                              : color ?? Colors.white,
                      fontSize: Insets.dim_16.sp,
                    ),
                  ),
        ),
      ),
    );
  }
}
