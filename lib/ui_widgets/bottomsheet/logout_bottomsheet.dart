import 'package:kobo_kobo/core/core.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:flutter/material.dart';

class LogoutBottomSheet extends StatelessWidget
    with BaseBottomSheetMixin, LogoutMixin {
  LogoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.symmetric(horizontal: Insets.dim_6),
      shadowColor: AppColors.black,
      backgroundColor: AppColors.white,
      elevation: 5,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Insets.dim_16),
      ),
      icon: const Icon(
        Icons.logout,
        size: 40,
        color: AppColors.borderErrorColor,
      ),
      title: Text(
        'Would you like to logout?',
        textAlign: TextAlign.center,
        style: context.textTheme.headlineLarge!.copyWith(
          color: AppColors.black.withOpacity(0.7),
          fontWeight: FontWeight.w500,
          fontSize: Insets.dim_24,
        ),
      ),
      actions: [
        AppButton(
          backgroundColor: AppColors.borderErrorColor,
          textTitle: 'Logout',
          action: logout,
        ),
      ],
    );
  }
}

class DialogPage<T> extends Page<T> {
  const DialogPage({
    required this.builder,
    this.anchorPoint,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
  });
  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final WidgetBuilder builder;

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
        context: context,
        settings: this,
        builder: builder,
        anchorPoint: anchorPoint,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        useSafeArea: useSafeArea,
        themes: themes,
      );
}
