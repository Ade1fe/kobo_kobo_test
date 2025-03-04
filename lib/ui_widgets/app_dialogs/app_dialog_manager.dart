import 'package:flutter/material.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class AfrDialogManager {
  static Future<AfrDialogAction> showConfirmationDialog({
    required BuildContext context,
    required String title,
    String? mainButtonText,
    String? body,
    bool isDismissible = false,
    bool isSuccessModal = true,
    bool showSecondaryButton = false,
  }) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isSuccessModal)
                    Icon(
                      Icons.check_circle,
                      size: MediaQuery.of(context).size.width * 0.14,
                      color: Colors.green,
                    )
                  else
                    Icon(
                      Icons.warning,
                      size: MediaQuery.of(context).size.width * 0.14,
                      color: Colors.orangeAccent,
                    ),
                  const YBox(8),
                  Text(
                    title,
                    style: context.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                      color: AppColors.black,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                  const YBox(8),
                  if (body != null)
                    Text(
                      body,
                      style: context.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.textBodyColor,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.start,
                    )
                  else
                    const SizedBox.shrink(),
                  const YBox(32),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: AppPrimaryButton(
                          textTitle: isSuccessModal
                              ? 'Add Beneficiary'
                              : mainButtonText ??= 'Cancel',
                          action: () => Navigator.of(context)
                              .pop(AfrDialogAction.confirm),
                        ),
                      ),
                      if (showSecondaryButton) ...[
                        const XBox(Insets.dim_10),
                        Expanded(
                          child: AppOutlineButton(
                            textTitle: 'Dismiss',
                            action: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    return (action != null) ? action : AfrDialogAction.abort;
  }
}
