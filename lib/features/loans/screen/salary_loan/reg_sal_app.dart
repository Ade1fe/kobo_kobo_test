import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/textfields/date_picker_form_field.dart';

import '../../../../ui_widgets/ui_widgets.dart';
import '../../../navigation/navigation.dart';

class RegSalApp extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final VoidCallback onClose;

  const RegSalApp({
    super.key,
    required this.onSubmit,
    required this.onClose,
  });

  @override
  _RegSalAppState createState() => _RegSalAppState();
}

class _RegSalAppState extends State<RegSalApp> {
  final TextEditingController _employerController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _payDateController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _salDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _employerController.dispose();
    _salaryController.dispose();
    _startDateController.dispose();
    _payDateController.dispose();
    _roleController.dispose();
    _salDateController.dispose();
    super.dispose();
  }

  void _continueToRegConApp() {
    if (_formKey.currentState!.validate()) {
      final formData = {
        'employer': _employerController.text,
        'salary': _salaryController.text,
        'startDate': _startDateController.text,
        'salaryDate': _salDateController.text,
        'payDate': _payDateController.text,
        'role': _roleController.text,
      };

      // widget.onSubmit(formData);
      // AppNavigator.of(context).push(AppRoutes.regConApp, args: formData);
      AppNavigator.of(context).push(AppRoutes.regConApp, args: formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: CustomAppBar(
        showLeading: true,
        onLeadingPressed: () => AppNavigator.of(context).push(AppRoutes.loans),
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 18.h),
                YBox(Insets.dim_22.h),
                Text(
                  'Loans',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.black.withValues(alpha: 0.8),
                    fontSize: Insets.dim_24.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Employment Details',
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withValues(alpha: 0.8),
                    fontSize: Insets.dim_18.sp,
                  ),
                ),
                SizedBox(height: 22.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextFormField(
                            labelText: 'Employer Name',
                            hintText: 'Input the name of your employer',
                            controller: _employerController,
                            validator: Validators.validateString(),
                          ),
                          SizedBox(height: 16.h),
                          AppTextFormField(
                            labelText: 'Salary Amount',
                            hintText: 'Enter amount you earn',
                            controller: _salaryController,
                            inputType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: Validators.validateString(),
                          ),
                          SizedBox(height: 16.h),
                          DatePickerFormField(
                            labelText: 'Salary Date',
                            hintText: 'DD/MM/YYYY',
                            controller: _salDateController,
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Please select a date'
                                : null,
                          ),
                          SizedBox(height: 16.h),
                          DatePickerFormField(
                            labelText: 'Employment Date',
                            hintText: 'DD/MM/YYYY',
                            controller: _startDateController,
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Please select a date'
                                : null,
                          ),
                          // SizedBox(height: 16.h),
                          // DatePickerFormField(
                          //   labelText: 'Next Pay Date',
                          //   hintText: 'DD/MM/YYYY',
                          //   controller: _payDateController,
                          //   validator: (value) => value?.isEmpty ?? true
                          //       ? 'Please select a date'
                          //       : null,
                          // ),
                          SizedBox(height: 16.h),
                          AppTextFormField(
                            labelText: 'Role',
                            hintText: 'What is your role in your company?',
                            controller: _roleController,
                            validator: Validators.validateString(),
                          ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  textTitle: "Continue",
                  action: _continueToRegConApp,
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
