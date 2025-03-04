import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/guarantors_dashboard/guarantors_loan_details.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';

import '../../ui_widgets/ui_widgets.dart';
import '../navigation/navigation.dart';

class GuarantorLoanOverview extends StatefulWidget {
  const GuarantorLoanOverview({super.key});

  @override
  _GuarantorLoanOverviewState createState() => _GuarantorLoanOverviewState();
}

class _GuarantorLoanOverviewState extends State<GuarantorLoanOverview> {
  bool _acceptTerms = false;
  bool _isAcceptClicked = false;
  bool _isRejectClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(14.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),
                      Text(
                        'Guarantor Loan Request from Adeyemi Temitope',
                        style: context.textTheme.bodySmall!.copyWith(
                          fontSize: Insets.dim_18.sp,
                          fontWeight: FontWeight.w400,
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
                      SizedBox(height: 10.h),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border(
                            bottom: BorderSide(
                              color:
                                  AppColors.appPrimaryButton.withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.appPrimaryButton.withOpacity(0.09),
                              blurRadius: 4,
                              offset: const Offset(0, 5),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildLoanDetailRow(
                                'Applicant’s Name', 'Adeyemi Temitope'),
                            _buildLoanDetailRow(
                                'Applicant’s Number', '08066119024'),
                            _buildLoanDetailRow('Applicant’s Address',
                                '57, Iron Bar Street, Igando, Lagos State '),
                            _buildLoanDetailRow('Loan Amount', '#25000'),
                            _buildLoanDetailRow('Tenure', '30 Days'),
                            _buildLoanDetailRow('Interest Rate', '10%'),
                            _buildLoanDetailRow(
                                'Monthly Repayment Amount', '#27500'),
                            _buildLoanDetailRow(
                                'Monthly Repayment Date', '12/12/24'),
                            SizedBox(height: 4.h),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.h),
              child: Row(
                children: [
                  Checkbox(
                    value: _acceptTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptTerms = value ?? false;
                      });
                    },
                    activeColor: Colors.orange,
                    checkColor: Colors.white,
                  ),
                  Expanded(
                    child: Text(
                      'By clicking this checkbox, you accept Kobokobo loan terms and conditions.',
                      style: context.textTheme.bodySmall!.copyWith(
                        fontSize: Insets.dim_14.sp,
                        color: AppColors.black.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const YBox(70),
            Padding(
              padding: EdgeInsets.all(12.h),
              child: _buildActionButton(
                "Accept",
                _isAcceptClicked,
                () {
                  setState(() {
                    _isAcceptClicked = true;
                    _isRejectClicked = false;
                  });
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const GuarantorsLoanDetails(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.h),
              child: _buildActionButton(
                "Reject",
                _isRejectClicked,
                () {
                  setState(() {
                    _isRejectClicked = true;
                    _isAcceptClicked = false;
                  });
                  // Future.delayed(const Duration(milliseconds: 200), () {
                  //   AppNavigator.of(context).pop();
                  // });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        contentPadding: EdgeInsets.all(16.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        content: Stack(
                          children: [
                            SizedBox(
                              width: 0.8.sw,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LocalImage(
                                    questImg,
                                    height: 100.h,
                                    width: 70.w,
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    'Reason for Rejecting',
                                    style:
                                        context.textTheme.bodySmall!.copyWith(
                                      fontSize: Insets.dim_16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  AppTextFormField(
                                    labelText: '',
                                    hintText: 'State your reason',
                                    maxLines: 3,
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 16.h),
                                  SizedBox(
                                    width: 200.w,
                                    child: AppPrimaryButton(
                                      textTitle: "Submit",
                                      action: () {
                                        Navigator.of(context).pop();
                                        _showSuccesModal();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: AppColors.appPrimaryButton,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccesModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: LocalImage(
                  failedPng,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'The loan request has been rejected',
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: Insets.dim_18.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              AppPrimaryButton(
                textTitle: "Done",
                action: () {
                  AppNavigator.of(context).pop();

                  AppNavigator.of(context).push(AppRoutes.home);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButton(
      String title, bool isClicked, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 48.h,
        decoration: BoxDecoration(
          color: isClicked ? AppColors.appPrimaryButton : Colors.transparent,
          border: Border.all(color: AppColors.appPrimaryButton),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title,
            style: context.textTheme.bodySmall!.copyWith(
              color: isClicked ? Colors.white : AppColors.appPrimaryButton,
              fontSize: Insets.dim_18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoanDetailRow(String label, String value) {
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
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
