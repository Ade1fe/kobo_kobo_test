import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:flutter/material.dart';

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
          const YBox(Insets.dim_8),
          if (svg != null) LocalSvgImage(svg!),
          if (img != null) LocalImage(img!),
          const YBox(Insets.dim_8),
          Text(
            error ?? 'An unexpected error occurred',
            textAlign: TextAlign.center,
          ),
          const YBox(Insets.dim_10),
          OutlinedButton.icon(
            style: ButtonStyle(
              elevation: WidgetStateProperty.all<double>(Insets.dim_0),
              backgroundColor:
                  WidgetStateProperty.all<Color>(AppColors.appPrimaryColor),
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(
                  vertical: Insets.dim_6,
                  horizontal: Insets.dim_12,
                ),
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: Corners.xsBorder,
                ),
              ),
            ),
            onPressed: onRetry,
            icon: const Icon(
              Icons.close,
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
