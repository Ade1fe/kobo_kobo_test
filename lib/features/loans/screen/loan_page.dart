import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'loan_home_page.dart';
import 'salary_loan/loan_application.dart';
import 'package:kobo_kobo/ui_widgets/toogle_app_bar.dart';

class LoanPage extends StatefulWidget {
  const LoanPage({super.key});

  @override
  State<LoanPage> createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  bool showEligibilityCheck = true;

  void toggleEligibilityCheck(bool value) {
    setState(() {
      showEligibilityCheck = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        title: const SizedBox.shrink(),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(12.h),
          child: Padding(
            padding: EdgeInsets.zero,
            child: ToggleAppBar(
              isEligibilityCheck: showEligibilityCheck,
              onToggle: toggleEligibilityCheck,
            ),
          ),
        ),
      ),
      body: showEligibilityCheck ? const LoanScreen() : const LoanApplication(),
    );
  }
}
