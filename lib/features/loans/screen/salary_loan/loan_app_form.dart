import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kobo_kobo/ui_widgets/textfields/date_picker_form_field.dart';
import 'package:kobo_kobo/ui_widgets/toogle_app_bar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

import '../../../navigation/navigation.dart';

class LoanAppForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final VoidCallback onClose;

  const LoanAppForm({
    super.key,
    required this.onSubmit,
    required this.onClose,
  });

  @override
  _LoanAppFormState createState() => _LoanAppFormState();
}

class _LoanAppFormState extends State<LoanAppForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _employerController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _payDateController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _lgaController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedState;
  String? _selectedLGA;
  String? _selectedFilePath;
  bool showEligibilityCheck = false;

  final Map<String, List<String>> _statesAndLGAs = {
    'Abia': ['Aba North', 'Aba South', 'Arochukwu'],
    'Adamawa': ['Demsa', 'Fufure', 'Ganye'],
    'Akwa Ibom': ['Abak', 'Eastern Obolo', 'Eket'],
  };

  @override
  void dispose() {
    _employerController.dispose();
    _salaryController.dispose();
    _startDateController.dispose();
    _payDateController.dispose();
    _roleController.dispose();
    _stateController.dispose();
    _lgaController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void toggleEligibilityCheck(bool value) {
    setState(() {
      showEligibilityCheck = value;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final formData = {
        'employer': _employerController.text,
        'salary': _salaryController.text,
        'startDate': _startDateController.text,
        'payDate': _payDateController.text,
        'role': _roleController.text,
        'state': _selectedState,
        'lga': _selectedLGA,
        'address': _addressController.text,
        'idCardPath': _selectedFilePath,
      };
      widget.onSubmit(formData);
      _showConfirmationModal(context);
    }
  }

  void _showConfirmationModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Salary Loan Application Summary',
                            style: TextStyle(
                              fontSize: 18.sp,
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
                          onPressed: () =>
                              // Navigator.pop(context)
                              AppNavigator.of(context).pop(),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Table(
                      border: TableBorder.all(color: AppColors.white),
                      children: [
                        _buildTableRow('Loan Amount', '#25000'),
                        _buildTableRow('Interest Rate', '6%'),
                        _buildTableRow('Repayment Amount', '26500'),
                        _buildTableRow('Repayment Date', '12/12/24'),
                        _buildTableRow(
                            'Employer\'s Name', _employerController.text),
                        _buildTableRow(
                            'Employer\'s Address', _addressController.text),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    AppPrimaryButton(
                      textTitle: "Confirm",
                      action: () {
                        // Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => Pinloan(
                        //       args: PinloanArgs(routeTo: ''),
                        //       onPinEntered: (pin) {
                        //         print(
                        //             'Loan application submitted successfully with PIN: $pin');
                        //         Navigator.pop(context);
                        //       },
                        //     ),
                        //   ),
                        // );
                        context.go(
                          '${AppRoutes.loans}/${AppRoutes.easyLoanViewAllPin}',
                        );
                      },
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(8.w),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.w),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _selectedFilePath = result.files.single.path;
      });
    }
  }

  void _showSelectionBottomSheet(
      String title, List<String> items, Function(String) onSelect) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: Insets.dim_18.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(items[index]),
                      onTap: () {
                        onSelect(items[index]);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showStateBottomSheet() {
    _showSelectionBottomSheet(
      'Select State',
      _statesAndLGAs.keys.toList(),
      (state) {
        setState(() {
          _selectedState = state;
          _stateController.text = state;
          _selectedLGA = null;
          _lgaController.clear();
        });
      },
    );
  }

  void _showLGABottomSheet() {
    if (_selectedState == null) return;

    _showSelectionBottomSheet(
      'Select LGA',
      _statesAndLGAs[_selectedState] ?? [],
      (lga) {
        setState(() {
          _selectedLGA = lga;
          _lgaController.text = lga;
        });
      },
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 22.h),
              _buildHeader(),
              SizedBox(height: 22.h),
              _buildEmploymentDetails(),
              SizedBox(height: 24.h),
              _buildLocationDetails(),
              SizedBox(height: 16.h),
              _buildIDUpload(),
              SizedBox(height: 24.h),
              AppPrimaryButton(
                textTitle: "Submit loan app",
                action: _submitForm,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Loan ',
          style: context.textTheme.bodySmall!.copyWith(
            fontSize: Insets.dim_18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 18.h),
        Text(
          'Employment Details',
          style: context.textTheme.bodySmall!.copyWith(
            fontSize: Insets.dim_18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildEmploymentDetails() {
    return Column(
      children: [
        AppTextFormField(
          labelText: 'Employer Name',
          hintText: 'Input the name of your employer',
          controller: _employerController,
          validator: Validators.validateString(),
        ),
        SizedBox(height: 16.h),
        AppTextFormField(
          labelText: 'Role',
          hintText: 'What is your role in your company?',
          controller: _roleController,
          validator: Validators.validateString(),
        ),
        SizedBox(height: 16.h),
        DatePickerFormField(
          labelText: 'Employment Start Date',
          hintText: 'DD/MM/YYYY',
          controller: _startDateController,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please select a date' : null,
        ),
        SizedBox(height: 16.h),
        DatePickerFormField(
          labelText: 'Next Pay Date',
          hintText: 'DD/MM/YYYY',
          controller: _payDateController,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please select a date' : null,
        ),
      ],
    );
  }

  Widget _buildLocationDetails() {
    return Column(
      children: [
        ClickableFormField(
          labelText: 'State',
          hintText: 'Select employer\'s state',
          controller: _stateController,
          onPressed: _showStateBottomSheet,
          validator: (value) =>
              value == null || value.isEmpty ? 'Please select a state' : null,
        ),
        SizedBox(height: 16.h),
        ClickableFormField(
          labelText: 'LGA',
          hintText: 'Select employer\'s LGA',
          controller: _lgaController,
          onPressed: _selectedState != null ? _showLGABottomSheet : null,
          validator: (value) =>
              value == null || value.isEmpty ? 'Please select an LGA' : null,
        ),
        SizedBox(height: 16.h),
        AppTextFormField(
          labelText: 'Address',
          hintText: 'Enter your employer\'s address',
          controller: _addressController,
          maxLines: 5,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the address';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildIDUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upload ID Card",
          style: context.textTheme.bodySmall!.copyWith(
            fontSize: Insets.dim_16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 8.h),
        DragTarget<String>(
          builder: (context, candidateData, rejectedData) {
            return InkWell(
              onTap: _pickFile,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                // color: AppColors.appPrimaryColor,
                strokeWidth: 2,
                dashPattern: const [8, 4],
                child: Container(
                  width: double.infinity,
                  height: 150.h,
                  decoration: BoxDecoration(
                    // color: AppColors.appPrimaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        color: AppColors.black.withOpacity(0.5),
                        size: 40.sp,
                      ),
                      SizedBox(height: 8.h),
                      if (_selectedFilePath != null)
                        Text(
                          _selectedFilePath!.split('/').last,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.black.withOpacity(0.88),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                  ),
                        )
                      else
                        Column(
                          children: [
                            Text(
                              'Take a picture to upload file or',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: AppColors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                  ),
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.black.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.arrow_upward,
                                    size: 16.sp,
                                    // color: AppColors.black.withOpacity(0.9),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'Browse file',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color:
                                              AppColors.black.withOpacity(0.9),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
          onAcceptWithDetails: (data) {
            setState(() {
              _selectedFilePath = data.data as String?;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        title: const SizedBox.shrink(),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            child: ToggleAppBar(
              isEligibilityCheck: showEligibilityCheck,
              onToggle: toggleEligibilityCheck,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: _buildMainContent(),
      ),
    );
  }
}
