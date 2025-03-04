import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:flutter/material.dart';

class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({
    required this.child,
    this.onDismiss,
    this.height,
    this.desc,
    this.title,
    this.isDismissible = true,
    this.centerTitle = false,
    this.showLeading = true,
    super.key,
  });

  final Widget child;
  final void Function()? onDismiss;
  final bool isDismissible;
  final bool centerTitle;
  final bool showLeading;
  final double? height;
  final String? title;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              height: context.getHeight(height ?? 0.3),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Insets.dim_14),
                  topLeft: Radius.circular(Insets.dim_14),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  if (height != null && height! > context.getHeight(0.5))
                    YBox(Insets.dim_60.h)
                  else
                    const YBox(kToolbarHeight),
                  if (title != null && title!.isNotEmpty)
                    CustomAppBar(
                      centerTitle: centerTitle,
                      showLeading: showLeading,
                      title: title,
                      leading: isDismissible && centerTitle
                          ? IconButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                );
                              },
                              icon: Icon(
                                Platform.isIOS
                                    ? Icons.chevron_left_rounded
                                    : Icons.arrow_back,
                                size: Insets.dim_32.sp,
                                color: AppColors.black,
                              ),
                              color: AppColors.appPrimaryColor,
                              splashRadius: 30,
                            )
                          : null,
                    ),
                  if (desc != null) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Insets.dim_16,
                        vertical: Insets.dim_8,
                      ),
                      child: Text(
                        desc ?? '',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: AppColors.black.withOpacity(0.5),
                          fontSize: Insets.dim_16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                  const YBox(Insets.dim_16),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Insets.dim_16),
                    child: child,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
