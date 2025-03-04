import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/functional_util/assets.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'salary_loan/salary_loan_homePage.dart';
import 'salary_loan/loan_overlay.dart';
import 'easi_loan/easy_loan_add_new.dart';
import 'dart:math';

class LoanScreen extends StatefulWidget {
  const LoanScreen({super.key});

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  int selectedTabIndex = 1;
  bool isLoading = false;
  bool? isEligible;
  bool showRegSalApp = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildMainContent(),
        if (isLoading || isEligible != null)
          LoanOverlay(
            isLoading: isLoading,
            isEligible: isEligible,
            onGoBack: resetEligibilityCheck,
          ),
        // if (showRegSalApp)
        //   RegSalApp(
        //     onSubmit: _handleSalaryRegistration,
        //     onClose: () => setState(() => showRegSalApp = false),
        //   ),
      ],
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          YBox(Insets.dim_16.h),
          _buildLoanImage(),
          YBox(Insets.dim_16.h),
          Text(
            'Product Name',
            style: TextStyle(
              fontSize: Insets.dim_16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black.withValues(alpha: .88),
            ),
          ),
          YBox(Insets.dim_10.h),
          _buildTabButtons(),
          YBox(Insets.dim_16.h),
          if (selectedTabIndex == 1) _buildLoanForm(),
          if (selectedTabIndex == 0) _buildEasyLoan(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      'Loan',
      style: TextStyle(
        fontSize: Insets.dim_24.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
    );
  }

  Widget _buildLoanImage() {
    return Center(
      child: LocalImage(
        selectedTabIndex == 1 ? loanImgOne : easiLoanImg,
        height: 0.2.sh,
        width: 0.5.sw,
      ),
    );
  }

  Widget _buildTabButtons() {
    return Row(
      children: [
        _buildTabButton('Salary Loan', 1),
        SizedBox(width: 16.w),
        _buildTabButton('Easi Loan', 0),
      ],
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isActive = selectedTabIndex == index;
    return Expanded(
      child: SizedBox(
        height: 40.h,
        child: isActive
            ? AppPrimaryButton(
                textTitle: title,
                action: () => setState(() => selectedTabIndex = index),
              )
            : AppOutlineButton(
                textTitle: title,
                action: () => setState(() => selectedTabIndex = index),
              ),
      ),
    );
  }

  Widget _buildLoanForm() {
    return LoanForm(
      onCheckEligibility: checkEligibility,
      onRegisterSalary: () =>
          AppNavigator.of(context).push(AppRoutes.regSalApp),
    );
  }

  Widget _buildEasyLoan() {
    return const EasyLoanAddNew();
  }

  Future<void> checkEligibility() async {
    setState(() {
      isLoading = true;
      isEligible = null;
    });

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      isLoading = false;
      isEligible = Random().nextBool();
    });
  }

  void resetEligibilityCheck() {
    setState(() {
      isEligible = null;
      isLoading = false;
    });
  }
}
