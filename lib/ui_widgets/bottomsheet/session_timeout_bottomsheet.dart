import 'package:kobo_kobo/core/core.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:flutter/material.dart';

class SessionTimeoutBottomSheet extends StatelessWidget
    with BaseBottomSheetMixin, LogoutMixin {
  SessionTimeoutBottomSheet(this.reason, {super.key});
  final String reason;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.dim_32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const YBox(Insets.dim_16),
          const Text(
            'Session expired',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
          ),
          const YBox(Insets.dim_8),
          Text(
            reason,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const YBox(Insets.dim_32),
          AppButton(
            textTitle: 'Log In',
            action: sessionExpiredLogout,
          ),
          const YBox(Insets.dim_16),
        ],
      ),
    );
  }
}
