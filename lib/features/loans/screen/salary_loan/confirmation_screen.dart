import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class ConfirmationScreen extends StatelessWidget {
  final VoidCallback onConfirm;

  const ConfirmationScreen({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        title: const Text('Loans'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 40),
                LocalImage(
                  emailImg,
                  height: 0.2.sh,
                  width: 0.5.sw,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'A request has been sent to your guarantor.',
                    style: context.textTheme.bodySmall!.copyWith(
                      fontSize: Insets.dim_16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          AppPrimaryButton(
            textTitle: "Go back",
            action: () {
              Navigator.pop(context);
              onConfirm();
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
