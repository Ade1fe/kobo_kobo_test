import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';

import '../../../../ui_widgets/ui_widgets.dart';
import '../../../navigation/navigation.dart';
// import 'loan_details_screen.dart';

class EasyLoanViewAll extends StatefulWidget {
  const EasyLoanViewAll({
    super.key,
  });

  @override
  _EasyLoanViewAllState createState() => _EasyLoanViewAllState();
}

class _EasyLoanViewAllState extends State<EasyLoanViewAll> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // _buildFormHeader(),
            SizedBox(height: 24.h),
            _buildViewAllContent()
          ],
        ),
      ),
    );
  }

  Widget _buildViewAllContent() {
    final loans = [
      {
        'title': 'Loan 1s',
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
        'repaymentDate': '01/05/2024',
        'status': 'Repaid',
        'dateDisbursed': '01 Jan 2024',
        'amountToPay': '0',
        'nextRepaymentDate': 'N/A',
      },
      {
        'title': 'Loan 5',
        'amount': '1,000',
        'interest': '8%',
        'repaymentDate': '01/05/2024',
        'status': 'Repaid',
        // 'dateDisbursed': '01 Jan 2024',
        'amountToPay': '0',
        'nextRepaymentDate': 'N/A',
      },
      {
        'title': 'Loan 6',
        'amount': '8,000',
        'interest': '8%',
        'repaymentDate': '01/05/2024',
        'status': 'Repaid',
        // 'dateDisbursed': '01 Jan 2024',
        'amountToPay': '0',
        'nextRepaymentDate': 'N/A',
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
                  // border: Border.all(
                  //   color: AppColors.appPrimaryColor,
                  //   width: 0.5,
                  // ),
                  // color: Colors.green,
                  color: AppColors.lightestRed,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF7517).withOpacity(0.25),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                    ),
                    BoxShadow(
                      color: const Color(0xFFFF7517).withOpacity(0.50),
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

  void _navigateToLoanDetailsScreen(
      BuildContext context, Map<String, String> loan) {
    context.go('${AppRoutes.loans}/${AppRoutes.easyLoanDetailsScreen}',
        extra: loan);
  }

  Widget _buildLoanDetailRow(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            // style: TextStyle(
            //   fontSize: 14.sp,
            //   fontWeight: FontWeight.w500,
            //   color: AppColors.black.withOpacity(0.7),
            // ),
            style: TextStyle(
              fontSize: Insets.dim_14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            // style: TextStyle(
            //   fontSize: 16.sp,
            //   fontWeight: FontWeight.w600,
            //   color: AppColors.black,
            // ),
            style: TextStyle(
              fontSize: Insets.dim_16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
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
      case 'pending':
        statusColor = Colors.blue.shade100;
        textColor = Colors.blue.shade700;
        break;

      default:
        statusColor = Colors.grey.shade100;
        textColor = Colors.grey.shade700;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Repayment Date: $repaymentDate',
          // style: TextStyle(
          //   fontSize: 14.sp,
          //   fontWeight: FontWeight.w500,
          //   color: AppColors.black.withOpacity(0.7),
          // ),
          style: context.textTheme.bodySmall!.copyWith(
            fontSize: Insets.dim_14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black.withValues(alpha: 0.7),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            status,
            // style: TextStyle(
            //   fontSize: 14.sp,
            //   fontWeight: FontWeight.bold,
            //   color: textColor,
            // ),
            style: context.textTheme.bodySmall!.copyWith(
              fontSize: Insets.dim_14.sp,
              // fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}
