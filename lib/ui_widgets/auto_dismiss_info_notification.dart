import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:flutter/material.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class DismissibleNotification extends StatefulWidget {
  const DismissibleNotification({
    super.key,
    required this.text,
    required this.imagePath,
    required this.isChecked,
  });
  final String text;
  final String imagePath;
  final bool isChecked;

  @override
  State<DismissibleNotification> createState() =>
      _DismissibleNotificationState();
}

class _DismissibleNotificationState extends State<DismissibleNotification> {
  late bool? _isVisible;

  @override
  void initState() {
    super.initState();
    updateWidget();
  }

  void updateWidget() {
    setState(() {
      _isVisible = widget.isChecked;
    });

    // Automatically dismiss after 10 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isVisible = false;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant DismissibleNotification oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isVisible!,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: AppColors.appPrimaryColor,
          ),
          borderRadius: Corners.xsBorder,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Row(
          children: [
            LocalSvgImage(
              widget.imagePath,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 20),
            Text(
              widget.text,
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.black.withOpacity(0.8),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: Insets.dim_24),
              child: LocalSvgImage(closeSquareSvg),
            ).onTap(() => setState(() => _isVisible = false)),
          ],
        ),
      ),
    );
  }
}
