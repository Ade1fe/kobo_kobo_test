import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.textStyle,
    this.onLeadingPressed,
    this.leading,
    this.actions,
    this.centerTitle,
    this.showLeading = true,
    this.backgroundColor,
    this.appBarTitleColor,
    this.leadingWidth = 56,
    this.useSmallFont = false,
    this.titleWidget,
    this.leadingColor,
    this.bottom,
  });

  final String? title;
  final TextStyle? textStyle;

  final VoidCallback? onLeadingPressed;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? appBarTitleColor;

  final bool? centerTitle;
  final bool showLeading;
  final double? leadingWidth;
  final bool useSmallFont;
  final Widget? titleWidget;
  final Color? leadingColor;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      title: title != null
          ? Text(
              title!,
              style: textStyle ??
                  context.textTheme.titleMedium!.copyWith(
                    color: AppColors.black.withOpacity(0.88),
                    fontWeight: FontWeight.w400,
                    fontSize:
                        useSmallFont ? Insets.dim_16.sp : Insets.dim_24.sp,
                  ),
            )
          : titleWidget ?? const SizedBox.shrink(),
      leading: !showLeading
          ? null
          : leading ??
              IconButton(
                onPressed:
                    onLeadingPressed ?? () => AppNavigator.of(context).pop(),
                icon: Icon(
                  Platform.isIOS
                      ? Icons.chevron_left_rounded
                      : Icons.arrow_back,
                  size: Insets.dim_32.sp,
                  color: leadingColor ?? AppColors.black,
                ),
                color: AppColors.appPrimaryColor,
                splashRadius: 30,
              ),
      leadingWidth: leadingWidth,
      actions: [
        ...?actions,
      ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        title == null && titleWidget == null ? Insets.dim_34 : Insets.dim_54,
      );
}
