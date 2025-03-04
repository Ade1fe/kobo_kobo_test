import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/more/screens/account_statement/selfscreen/customImage_dropdown.dart'; // Ensure this import is correct based on your folder structure
import 'package:kobo_kobo/features/more/screens/account_statement/selfscreen/self_pin.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/textfields/date_picker_form_field.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class SelfScreen extends StatefulWidget {
  const SelfScreen({super.key});

  @override
  State<SelfScreen> createState() => _SelfScreenState();
}

class _SelfScreenState extends State<SelfScreen> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedAccountType;

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  // ignore: unused_element
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Start Date: ${_fromDateController.text}');
      print('Form submitted with selected account type: $_selectedAccountType');
    }
  }

  void _handleItemSelected(String? selectedItem) {
    setState(() {
      _selectedAccountType = selectedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Your Account Statement will be sent to t****@gmail.com. The maximum statement period is 6 months.',
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: Insets.dim_16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Source Account ',
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: Insets.dim_16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black.withOpacity(0.8),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: LocalImage(
                        atIconImg,
                        height: 40.h,
                        width: 40.w,
                      ),
                    ),
                    Expanded(
                      child: CustomImageDropdown(
                        onItemSelected: _handleItemSelected,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              DatePickerFormField(
                labelText: 'From:',
                hintText: 'DD/MM/YYYY',
                controller: _fromDateController,
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: Insets.dim_16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black.withOpacity(0.8),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please select a date' : null,
              ),
              SizedBox(height: 16.h),
              DatePickerFormField(
                labelText: 'To:',
                hintText: 'DD/MM/YYYY',
                controller: _toDateController,
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: Insets.dim_16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black.withOpacity(0.8),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please select a date' : null,
              ),
              SizedBox(height: 24.h),
              Text(
                'Statement Format',
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: Insets.dim_16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black.withOpacity(0.8),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 20.h),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 160.w,
                        height: 40.h,
                        child:
                            AppOutlineButton(textTitle: 'PDF', action: () {}),
                      ),
                      SizedBox(width: 12.w),
                      SizedBox(
                        width: 160.w,
                        height: 40.h,
                        child:
                            AppOutlineButton(textTitle: 'EXCEL', action: () {}),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 24.h),
              const YBox(40),
              AppPrimaryButton(
                textTitle: "Send",
                action: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelfPin(
                        args: SelfPinArgs(routeTo: ''),
                        onPinEntered: (pin) {
                          print(
                              'Loan application submitted successfully with PIN: $pin');
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
