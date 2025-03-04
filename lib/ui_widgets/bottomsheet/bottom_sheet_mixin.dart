import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

import 'package:flutter/material.dart';

mixin BaseBottomSheetMixin {
  Widget build(BuildContext context);

  Future<R?> show<R>(
    BuildContext context, {
    bool isDismissible = true,
    bool enableDrag = true,
    Function()? onDismiss,
  }) async {
    final result = await showModalBottomSheet<R>(
      isScrollControlled: true,
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      barrierColor: AppColors.black.withOpacity(0.3),
      builder: build,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Insets.dim_16),
        ),
      ),
    );
    onDismiss?.call();
    return Future.value(result);
  }
}
