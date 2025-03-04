import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/presentation/navigator.dart';
import 'package:kobo_kobo/functional_util/assets.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class LoanRej extends StatelessWidget {
  const LoanRej({super.key});

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
                  emailRejImg,
                  height: 0.2.sh,
                  width: 0.4.sw,
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(22),
                  child: Text(
                    'We are sorry! Your guarantor has rejected your loan request. ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          // const SizedBox(height: 40),
          const Spacer(),
          AppPrimaryButton(
            textTitle: "Assign  a new Guarantor",
            action: () {
              // Navigator.pop(context);
              AppNavigator.of(context).pop();
            },
          ),
          const SizedBox(height: 20),
          AppOutlineButton(
            textTitle: "Cancel loan request",
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

// Usage: To navigate to the LoanRej page
