import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kobo_kobo/functional_util/assets.dart';
import 'package:kobo_kobo/functional_util/extensions/context_extension.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

import '../navigation/navigation.dart';

class GuarantorsLoanDetails extends StatefulWidget {
  const GuarantorsLoanDetails({super.key});

  @override
  State<GuarantorsLoanDetails> createState() => _GuarantorsLoanDetailsState();
}

class _GuarantorsLoanDetailsState extends State<GuarantorsLoanDetails> {
  final bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 16.h),
                    Text(
                      'Choose investment account you wish to use to guarantee the loan',
                      style: context.textTheme.bodySmall!.copyWith(
                        fontSize: Insets.dim_16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black.withValues(alpha: 0.8),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    const InAppSourceAccount(),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
              Text(
                'Note: You can only guarantee one loan at a time.',
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: Insets.dim_16.sp,
                  color: AppColors.black.withValues(alpha: 0.8),
                ),
              ),
              SizedBox(height: 16.h),
              AppButton(
                textTitle: 'Confirm',
                action: _showSuccessModal,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String title,
      {required VoidCallback onPressed, bool isActive = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: Insets.dim_40.h,
          decoration: BoxDecoration(
            color: isActive ? AppColors.appPrimaryButton : Colors.transparent,
            border: Border.all(color: AppColors.appPrimaryButton),
            borderRadius: Corners.smBorder,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Insets.dim_12.w,
            vertical: Insets.dim_8.h,
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: Insets.dim_14.sp,
                    color:
                        isActive ? AppColors.white : AppColors.appPrimaryButton,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            bool isCancelActive = false;
            bool isContinueActive = false;

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
                      lockSavingsPng,
                      height: context.getHeight(0.09.h),
                      width: context.getWidth(0.15.w),
                    ),
                  ),
                  Text(
                    'Important Notice',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Please note that your selected investment will be used to cover any outstanding loan balance in case of default.',
                    style: context.textTheme.bodySmall!.copyWith(
                      fontSize: Insets.dim_14.sp,
                      color: AppColors.black.withValues(alpha: 0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTabButton(
                        'Cancel',
                        onPressed: () {
                          setState(() {
                            isCancelActive = true;
                            isContinueActive = false;
                          });
                          Future.delayed(const Duration(milliseconds: 200), () {
                            AppNavigator.of(context).pop();
                          });
                        },
                        isActive: isCancelActive,
                      ),
                      const SizedBox(width: 16),
                      _buildTabButton(
                        'Continue',
                        onPressed: () {
                          setState(() {
                            isCancelActive = false;
                            isContinueActive = true;
                          });
                          Future.delayed(const Duration(milliseconds: 200), () {
                            AppNavigator.of(context).pop();
                            _showSummaryModal();
                          });
                        },
                        isActive: isContinueActive,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showSummaryModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Summary',
                          style: context.textTheme.bodySmall!.copyWith(
                            fontSize: Insets.dim_18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.appPrimaryButton,
                        ),
                        onPressed: () => AppNavigator.of(context).pop(),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _buildLoanDetailRow('Loan Amount', '₦500'),
                  SizedBox(height: 16.h),
                  _buildLoanDetailRow('Tenure', '30 days'),
                  SizedBox(height: 16.h),
                  _buildLoanDetailRow('Interest Rate', '5%'),
                  SizedBox(height: 16.h),
                  _buildLoanDetailRow('Monthly Repayment Amount', '#1200'),
                  SizedBox(height: 16.h),
                  _buildLoanDetailRow('Monthly Repayment Date', '12/12/24'),
                  SizedBox(height: 16.h),
                  _buildLoanDetailRow('Applicant\'s name', 'Adeyemi Temitope'),
                  SizedBox(height: 16.h),
                  _buildLoanDetailRow(
                      'Applicant\'s Phone Number', '08066119024'),
                  SizedBox(height: 24.h),
                  AppPrimaryButton(
                    textTitle: "Confirm",
                    action: () {
                      context.go(
                        '${AppRoutes.notificationRoute}/${AppRoutes.guarantorsPin}',
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoanDetailRow(String label, String value) {
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
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            // style: context.textTheme.bodyMedium!.copyWith(
            //   fontSize: Insets.dim_14.sp,
            //   fontWeight: FontWeight.bold,
            //   color: AppColors.black.withValues(alpha: 0.6),)
            style: context.textTheme.bodySmall!.copyWith(
              fontSize: Insets.dim_16.sp,
              color: AppColors.black.withValues(alpha: 0.6),
            ),
          ),
          Text(value,
              // style: TextStyle(
              //     fontSize: 14.sp,
              //     fontWeight: FontWeight.w500,
              //     color: textColor)

              style: context.textTheme.bodyMedium!.copyWith(
                fontSize: Insets.dim_18.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              )),
        ],
      ),
    );
  }
}
