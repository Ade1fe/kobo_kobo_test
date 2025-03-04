import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kobo_kobo/features/navigation/presentation/navigator.dart';
import 'package:kobo_kobo/functional_util/assets.dart';
import 'package:kobo_kobo/functional_util/extensions/context_extension.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../ui_widgets/ui_widgets.dart';
import '../../../navigation/presentation/routes/routes.dart';

class LoanForm extends StatefulWidget {
  final VoidCallback onCheckEligibility;
  final VoidCallback onRegisterSalary;

  const LoanForm({
    super.key,
    required this.onCheckEligibility,
    required this.onRegisterSalary,
  });

  @override
  _LoanFormState createState() => _LoanFormState();
}

class _LoanFormState extends State<LoanForm> {
  String _activeTab = 'Add New';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildFormHeader(),
            SizedBox(height: 24.h),
            if (_activeTab == 'Add New') _buildAddNewContent(),
            if (_activeTab == 'View All') _buildViewAllContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormHeader() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 200, 202, 208),
            width: 1.0,
          ),
        ),
      ),
      padding: EdgeInsets.only(bottom: 0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTab('Add New', img: addEIcon),
          _buildTab('View All'),
        ],
      ),
    );
  }

  Widget _buildTab(String title, {String? img}) {
    final isActive = _activeTab == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeTab = title;
        });
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColors.appPrimaryButton : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: Insets.dim_16.sp,
                fontWeight: FontWeight.w400,
                color: isActive
                    ? AppColors.appPrimaryButton
                    : AppColors.black.withValues(alpha: 0.7),
              ),
            ),
            if (img != null) SizedBox(width: 8.w),
            if (img != null)
              LocalImage(
                img,
                height: 20.h,
                width: 20.w,
              ),
            if (img != null) SizedBox(width: 8.w),
          ],
        ),
      ),
    );
  }

  void showLoanModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: AppColors.white,
            child: _buildLoanModalContent(context),
          ),
        );
      },
    );
  }

  Widget _buildLoanModalContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 40.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close, color: AppColors.appPrimaryButton),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          LocalImage(
            loanModaImg,
            height: 0.2.sh,
            width: 0.5.sw,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Text(
              "Have Your Registered Your Salary Details?",
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: Insets.dim_18.sp,
                color: AppColors.black.withValues(alpha: 0.8),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          AppPrimaryButton(
            textTitle: "Yes, I Have",
            action: () {
              AppNavigator.of(context).pop();
              widget.onCheckEligibility();
            },
          ),
          SizedBox(height: 16.h),
          AppOutlineButton(
            textTitle: "I Want To Register",
            action: () {
              AppNavigator.of(context).pop();
              widget.onRegisterSalary();
            },
            isOutlined: true,
          ),
        ],
      ),
    );
  }

  Widget _buildViewAllContent() {
    final loans = [
      {
        'title': 'Loans 1',
        'interest': '9%',
        'amount': '5,000',
        'repaymentDate': '12/12/2024',
        'status': 'Active',
        'dateDisbursed': '10 Sept 2024',
        'amountToPay': '500',
        'nextRepaymentDate': '12 Oct 2024',
      },
      {
        'title': 'Loan 2',
        'amount': '5,000',
        'interest': '6%',
        'repaymentDate': '12/12/2024',
        'status': 'Overdue',
        'dateDisbursed': '15 Aug 2024',
        'amountToPay': '750',
        'nextRepaymentDate': '15 Sept 2024',
      },
      {
        'title': 'Loan 3',
        'amount': '3,000',
        'interest': '7%',
        'repaymentDate': '01/05/2024',
        'status': 'Repaid',
        'dateDisbursed': '01 Jan 2024',
        'amountToPay': '0',
        'nextRepaymentDate': 'N/A',
      },
      {
        'title': 'Loan 4',
        'amount': '7,000',
        'interest': '8%',
        'repaymentDate': 'Pending',
        'status': 'In Review',
        'dateDisbursed': 'Pending',
        'amountToPay': 'TBD',
        'nextRepaymentDate': 'TBD',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: loans.length,
          itemBuilder: (context, index) {
            final loan = loans[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.appPrimaryColor,
                    width: 0.5,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: const Color(0xFFFF7517).withValues(alpha: 0.25),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                    ),
                    BoxShadow(
                      color: const Color(0xFFFF7517).withValues(alpha: 0.50),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () => _navigateToLoanDetailsScreen(context, loan),
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loan['title']!,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildLoanDetailRow('Amount', loan['amount']!),
                            _buildLoanDetailRow('Interest', loan['interest']!),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        _buildRepaymentAndStatusRow(
                          loan['repaymentDate']!,
                          loan['status']!,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAddNewContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletPoint('Quick and Hassle-Free Approval'),
        SizedBox(height: 20.h),
        _buildBulletPoint('Competitive Interest Rates'),
        SizedBox(height: 20.h),
        _buildBulletPoint('No Collateral or Guarantors Required'),
        SizedBox(height: 20.h),
        _buildBulletPoint('Repayment Matched With Your Salary Date'),
        YBox(context.getHeight(0.10.h)),
        AppPrimaryButton(
          textTitle: 'Check Eligibility',
          action: () {
            showLoanModal(context);
          },
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      children: [
        LocalSvgImage(loanFingerSvg),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: context.textTheme.bodySmall!.copyWith(
              fontSize: Insets.dim_16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black.withValues(alpha: 0.6),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToLoanDetailsScreen(
      BuildContext context, Map<String, String> loan) {
    context.push('${AppRoutes.loans}/${AppRoutes.loanDetails}', extra: loan);
  }

  Widget _buildLoanDetailRow(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            // style: TextStyle(
            //   fontSize: 16.sp,
            //   fontWeight: FontWeight.w500,
            //   color: AppColors.black.withValues(alpha: 0.5),
            // ),
            style: context.textTheme.bodySmall!.copyWith(
              fontSize: Insets.dim_16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black.withValues(alpha: 0.5),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            // style: TextStyle(
            //   fontSize: 18.sp,
            //   fontWeight: FontWeight.w600,
            //   color: AppColors.black,
            // ),
            style: context.textTheme.bodySmall!.copyWith(
              fontSize: Insets.dim_18.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRepaymentAndStatusRow(String repaymentDate, String status) {
    Color statusColor;
    Color textColor;
    switch (status.toLowerCase()) {
      case 'active':
        statusColor = Colors.green.shade100;
        textColor = Colors.green.shade700;
        break;
      case 'overdue':
        statusColor = Colors.red.shade100;
        textColor = Colors.red.shade700;
        break;
      case 'repaid':
        statusColor = Colors.blue.shade100;
        textColor = Colors.blue.shade700;
        break;
      case 'in review':
        statusColor = Colors.orange.shade100;
        textColor = Colors.orange.shade700;
        break;
      default:
        statusColor = Colors.grey.shade100;
        textColor = Colors.grey.shade700;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'Repayment Dates: ',
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: Insets.dim_14.sp,
                color: AppColors.black.withValues(alpha: 0.7),
              ),
            ),
            Text(
              repaymentDate,
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: Insets.dim_14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            status,
            style: context.textTheme.displayMedium!.copyWith(
                fontSize: Insets.dim_12.sp,
                color: textColor,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
