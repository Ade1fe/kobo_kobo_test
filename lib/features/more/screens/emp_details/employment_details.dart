import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/more/screens/emp_details/location_details_screen.dart';
import 'package:kobo_kobo/features/more/screens/account_statement/selfscreen/customImage_dropdown.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
// import 'package:kobo_kobo/functional_util/validators.dart';
// import 'package:kobo_kobo/ui_widgets/app_scaffold.dart';
// import 'package:kobo_kobo/ui_widgets/constants/numbers.dart';
// import 'package:kobo_kobo/ui_widgets/image.dart';
// import 'package:kobo_kobo/ui_widgets/textfields/app_textfield.dart';
import 'package:kobo_kobo/ui_widgets/textfields/date_picker_form_field.dart';
// import '../../../../functional_util/assets.dart';
// import '../../../../ui_widgets/app_button.dart';
import '../../../../ui_widgets/ui_widgets.dart';
// import '../../../../ui_widgets/constants/constants.dart';

class EmploymentDetailsScreen extends StatefulWidget {
  const EmploymentDetailsScreen({super.key});

  @override
  _EmploymentDetailsScreenState createState() =>
      _EmploymentDetailsScreenState();
}

class _EmploymentDetailsScreenState extends State<EmploymentDetailsScreen> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // String? _selectedAccountType;

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(
        showLeading: true,
        leadingColor: AppColors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(1.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Employment Details',
                    style: context.textTheme.bodySmall!.copyWith(
                      fontSize: Insets.dim_24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  const Divider(height: 1, thickness: 1.0),
                  SizedBox(height: 22.h),
                  _buildProfileImage(),
                  SizedBox(height: 12.h),
                  _buildEmployeeInfo(),
                  SizedBox(height: 16.h),
                  _buildEditableField(
                    label: 'Employer Name',
                    hint: 'Kobokobo Nigeria Limited',
                    validator: Validators.validateString(),
                  ),
                  SizedBox(height: 16.h),
                  _buildEditableField(
                    label: 'Amount',
                    hint: '#25,000',
                    validator: Validators.validateString(),
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                  SizedBox(height: 16.h),
                  _buildEditableDropdown(),
                  SizedBox(height: 16.h),
                  _buildDatePickerField(
                    label: 'Salary Date:',
                    hint: '20/11/2024',
                    controller: _fromDateController,
                  ),
                  SizedBox(height: 16.h),
                  _buildDatePickerField(
                    label: 'Employment Date:',
                    hint: '30/11/2024',
                    controller: _toDateController,
                  ),
                  SizedBox(height: 16.h),
                  _buildEditableField(
                    label: 'Role',
                    hint: 'Product Designer',
                    validator: Validators.validateString(),
                  ),
                  SizedBox(height: 40.h),
                  AppPrimaryButton(
                    textTitle: 'Continue',
                    action: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const LocationDetailsScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 112.w,
        height: 112.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.red,
            width: 2.w,
          ),
        ),
        padding: EdgeInsets.all(8.w),
        child: ClipOval(
          child: LocalImage(
            empProfilePic,
            width: 112.w,
            height: 112.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeInfo() {
    return Center(
      child: Column(
        children: [
          Text(
            'Temitope Adeyemi',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Product Designer',
            // style: TextStyle(
            //   fontSize: 14.sp,
            //   color: Colors.grey[600],
            // ),
            style: context.textTheme.bodySmall!.copyWith(
              fontSize: Insets.dim_14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required String hint,
    required String? Function(String?) validator,
    TextInputType inputType = TextInputType.text,
  }) {
    return Stack(
      children: [
        AppTextFormField(
          labelText: label,
          hintText: hint,
          validator: validator,
          inputType: inputType,
        ),
        Positioned(
          right: 8.w,
          top: 8.h,
          child: Row(
            children: [
              Text(
                'Edit',
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: Insets.dim_16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 4.w),
              LocalImage(
                editIconImg,
                width: 20.w,
                height: 20.h,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEditableDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Source Account",
                style: context.textTheme.bodyMedium!.copyWith(
                  fontSize: Insets.dim_16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
              right: 8.w,
              child: Row(
                children: [
                  Text(
                    'Edit',
                    style: context.textTheme.bodySmall!.copyWith(
                      fontSize: Insets.dim_16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  LocalImage(
                    editIconImg,
                    width: 20.w,
                    height: 20.h,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ],
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
                  onItemSelected: (selectedItem) {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDatePickerField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Stack(
      children: [
        DatePickerFormField(
          labelText: label,
          hintText: hint,
          controller: controller,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please select a date' : null,
        ),
        Positioned(
          right: 8.w,
          top: 8.h,
          child: Row(
            children: [
              Text(
                'Edit',
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: Insets.dim_16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 4.w),
              LocalImage(
                editIconImg,
                width: 20.w,
                height: 20.h,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
