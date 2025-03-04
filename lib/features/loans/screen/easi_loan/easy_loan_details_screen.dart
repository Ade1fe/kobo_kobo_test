import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kobo_kobo/features/loans/screen/easi_loan/easy_loan_view_all_pin.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

import '../../../navigation/navigation.dart';

class EasyLoanDetailsScreen extends StatelessWidget {
  final Map<String, String> loan;

  const EasyLoanDetailsScreen({super.key, required this.loan});

  // if Guarantor include the fields

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(1.h),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.9),
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.appPrimaryButton.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.appPrimaryButton.withOpacity(0.09),
                          blurRadius: 4,
                          offset: const Offset(0, 5),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loan['title'] ?? 'Loan Details',
                          style: context.textTheme.bodySmall!.copyWith(
                            fontSize: Insets.dim_18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Overview',
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontSize: Insets.dim_16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        _buildLoanDetailRow(
                            'Loan Name', loan['title'] ?? '', context),
                        _buildLoanDetailRow(
                            'Amount', loan['amount'] ?? '', context),
                        _buildLoanDetailRow(
                            'Interest Rate', loan['interest'] ?? '', context),
                        _buildLoanDetailRow('Repayment Schedule',
                            'Principal + Interest', context),
                        _buildLoanDetailRow(
                            'Guarantor', 'Adeyemi Temitope', context),
                        _buildLoanDetailRow(
                            'Guarantor’s Address',
                            '57, Iron Bar Street, Igando, Lagos State ',
                            context),
                        _buildLoanDetailRow(
                            'Repayment Plan', 'Monthly', context),
                        _buildLoanDetailRow('Amount to Pay',
                            loan['amountToPay'] ?? '500', context),
                        _buildLoanDetailRow(
                            'Next Repayment Date',
                            loan['nextRepaymentDate'] ?? '12 Oct 2024',
                            context),
                        _buildLoanDetailRow(
                            'Loan Status', loan['status'] ?? '', context),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (loan['status']?.toLowerCase() != 'repaid')
              Padding(
                padding: EdgeInsets.all(16.h),
                child: AppPrimaryButton(
                  textTitle: "Repay",
                  action: () {
                    final args = EasyLoanViewAllPinArgs.fromMap(loan);
                    context.go(
                        '${AppRoutes.loans}/${AppRoutes.easyLoanViewAllPin}',
                        extra: args);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanDetailRow(String label, String value, BuildContext context) {
    Color textColor = AppColors.black;
    if (label == 'Loan Status') {
      switch (value.toLowerCase()) {
        case 'active':
          textColor = Colors.green;
          break;
        case 'overdue':
          textColor = Colors.red;
          break;
        case 'repaid':
          textColor = Colors.blue;
          break;
        case 'in review':
          textColor = Colors.orange;
          break;
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: Insets.dim_16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: context.textTheme.bodyMedium!.copyWith(
                fontSize: Insets.dim_16.sp,
                fontWeight: FontWeight.w500,
                color: label == 'Loan Status' ? textColor : AppColors.black,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
