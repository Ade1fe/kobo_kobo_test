import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/textfields/date_picker_form_field.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

import '../../../navigation/presentation/routes/routes.dart';

class LoanApplication extends StatefulWidget {
  const LoanApplication({super.key});

  @override
  State<LoanApplication> createState() => _LoanApplicationState();
}

class _LoanApplicationState extends State<LoanApplication> {
  final TextEditingController _desiredAmountController =
      TextEditingController();
  final TextEditingController _repaymentDateController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isAmountVisible = true;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _desiredAmountController.dispose();
    _repaymentDateController.dispose();
    super.dispose();
  }

  void _toggleAmountVisibility() {
    setState(() {
      _isAmountVisible = !_isAmountVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(1.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 16.h),
              _buildLoanInfoCard(),
              SizedBox(height: 16.h),
              _buildLoanForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Loan',
          style: context.textTheme.bodySmall!.copyWith(
            fontSize: Insets.dim_24.sp,
            color: AppColors.black.withValues(alpha: 0.8),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Congratulations! You are eligible for a loan.',
          style: context.textTheme.bodySmall!.copyWith(
            fontSize: Insets.dim_14.sp,
            color: AppColors.black.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildLoanInfoCard() {
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        color: AppColors.appPrimaryColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: LocalImage(
              scaffoldTopBottomPng,
              height: 100.h,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildLoanAmount(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoanAmount() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Eligible Amount',
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: Insets.dim_14.sp,
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isAmountVisible ? '₦1,256,093.00' : '••••••',
                    // style: TextStyle(
                    //   fontSize: 24.sp,
                    //   fontWeight: FontWeight.w700,
                    //   color: Colors.white,
                    // ),
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontSize: Insets.dim_24.sp,
                      color: AppColors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: _toggleAmountVisibility,
                    child: Icon(
                      _isAmountVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                      size: 24.sp,
                      semanticLabel:
                          _isAmountVisible ? 'Hide amount' : 'Show amount',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            height: 1,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildLoanForm() {
    return Container(
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 18.h),
            AppTextFormField(
              labelText: 'Desired Amount',
              hintText: 'Enter your desired amount',
              controller: _desiredAmountController,
              validator: Validators.validateString(),
              inputType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: Insets.dim_16.sp,
                color: AppColors.black.withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: 20.h),
            DatePickerFormField(
              labelText: 'Repayment Date',
              hintText: '25/04/2024',
              controller: _repaymentDateController,
              validator: Validators.validateString(),
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: Insets.dim_16.sp,
                color: AppColors.black.withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: 10.h),
            _buildTermsCheckbox(),
            const YBox(80),
            AppPrimaryButton(
              textTitle: "Continue",
              action: () {
                if (_formKey.currentState!.validate() && _acceptTerms) {
                  // context.go('${AppRoutes.loans}/${AppRoutes.loanAppForm}');
                  context.go(
                    '${AppRoutes.loans}/${AppRoutes.loanSuccessModal}',
                  );
                }
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        SizedBox(
          width: 24.w,
          height: 24.h,
          child: Checkbox(
            value: _acceptTerms,
            onChanged: (value) {
              setState(() {
                _acceptTerms = value ?? false;
              });
            },
            shape: const RoundedRectangleBorder(
              borderRadius: Corners.rsBorder,
            ),
            checkColor: AppColors.white,
            activeColor: AppColors.appPrimaryButton,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            'By clicking this checkbox, you accept Kobokobo loan terms and conditions',
            style: context.textTheme.bodySmall!.copyWith(
              fontSize: Insets.dim_12.sp,
              color: AppColors.black.withValues(alpha: 0.8),
            ),
          ),
        ),
      ],
    );
  }
}
