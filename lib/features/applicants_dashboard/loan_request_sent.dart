import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/presentation/navigator.dart';
import 'package:kobo_kobo/functional_util/assets.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class LoanRequestSent extends StatelessWidget {
  const LoanRequestSent({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        title: const Text('Loans'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 40),
                LocalImage(
                  emailSentImg,
                  height: 0.2.sh,
                  width: 0.5.sw,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your loan request has been sent to your guarantor and is awaiting acceptance.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // const SizedBox(height: 40),
          const Spacer(),
          AppPrimaryButton(
            textTitle: "Go To Homepage",
            action: () {
              // Navigator.pop(context);
               AppNavigator.of(context).pop();
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// Usage: To navigate to the LoanRequestSent page
