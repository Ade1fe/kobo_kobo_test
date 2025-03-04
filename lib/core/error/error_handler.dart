import 'package:flutter/material.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    this.error,
    this.onRetry,
    this.buttonText,
    this.svg,
    this.img,
    super.key,
  });

  final Function()? onRetry;
  final String? error;
  final String? buttonText;

  final String? svg;
  final String? img;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const YBox(Insets.dim_12),
          if (svg != null) LocalSvgImage(svg!),
          if (img != null) LocalImage(img!),
          const YBox(Insets.dim_12),
          Text(
            error ?? 'An unexpected error occurred',
            textAlign: TextAlign.center,
          ),
          const YBox(10),
          OutlinedButton.icon(
            style: ButtonStyle(
              elevation: WidgetStateProperty.all<double>(0),
              backgroundColor:
                  WidgetStateProperty.all<Color>(AppColors.appPrimaryColor),
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(
                  vertical: Insets.dim_12,
                  horizontal: Insets.dim_16,
                ),
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: Corners.smBorder,
                ),
              ),
            ),
            onPressed: onRetry,
            icon: Icon(
              PhosphorIcons.arrowCounterClockwise(),
              size: 20,
              color: Colors.white,
            ),
            label: Text(
              buttonText ?? 'Retry',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
