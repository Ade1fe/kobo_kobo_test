import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kobo_kobo/features/loans/screen/easi_loan/easy_loan_view_all.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';

class EasyLoanAddNew extends StatefulWidget {
  const EasyLoanAddNew({super.key});

  @override
  State<EasyLoanAddNew> createState() => _EasyLoanAddNewState();
}

class _EasyLoanAddNewState extends State<EasyLoanAddNew> {
  String _activeTab = 'Add New';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _desiredAmountController =
      TextEditingController();
  final TextEditingController _tenureController = TextEditingController();
  final TextEditingController _guarantorController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _loanNameController = TextEditingController();

  final List<String> tenureOptions = [
    '30 days',
    '60 days',
    '180 days',
    '210 days'
  ];
  final List<String> guarantorOptions = ['Self', 'External'];

  String _guarantorType = '';
  bool _isInvestmentEnough = false;
  bool _isGuarantor = false;
  final bool _isExpanded = false;

  @override
  void dispose() {
    _desiredAmountController.dispose();
    _tenureController.dispose();
    _guarantorController.dispose();
    _phoneNumberController.dispose();
    _loanNameController.dispose();
    super.dispose();
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
                // style: TextStyle(
                //   fontSize: Insets.dim_18.sp,
                //   fontWeight: FontWeight.w400,
                //   color: AppColors.black,
                // ),
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: Insets.dim_18.sp,
                  color: AppColors.black.withValues(alpha: 0.6),
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
                        AppNavigator.of(context).pop();
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

  void _showTenureBottomSheet() {
    _showSelectionBottomSheet(
      'Select Tenure',
      tenureOptions,
      (tenure) {
        setState(() {
          _tenureController.text = tenure;
        });
      },
    );
  }

  void _showGuarantorBottomSheet() {
    _showSelectionBottomSheet(
      'Select Guarantor',
      guarantorOptions,
      (guarantor) {
        setState(() {
          _guarantorController.text = guarantor;
          _guarantorType = guarantor == 'Self' ? 'self' : 'external';
        });
      },
    );
  }

  Widget _buildInvestmentAccountInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const InAppSourceAccount(),
        SizedBox(height: 16.h),
        if (!_isInvestmentEnough)
          Text(
            'Sorry your investment is not enough to guarantee this loan. Please reduce the loan amount and try again.',
            style: context.textTheme.bodyMedium!.copyWith(
              fontSize: Insets.dim_14.sp,
              color: Colors.red,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  void _simulateInvestmentCheck(double amount) {
    setState(() {
      _isInvestmentEnough = amount <= 100;
    });
  }

  void _simulateGuarantorCheck(String phoneNumber) {
    setState(() {
      _isGuarantor = phoneNumber.length == 11;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildFormHeader(),
            SizedBox(height: 24.h),
            if (_activeTab == 'View All') _buildViewAllContent(),
            if (_activeTab == 'Add New') _buildAddNewContent(),
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
                    : AppColors.black.withOpacity(0.7),
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

  Widget _buildViewAllContent() {
    return const EasyLoanViewAll();
  }

  Widget _buildAddNewContent() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 16.h),
          if (_guarantorType == 'external')
            Column(
              children: [
                AppTextFormField(
                  labelText: 'Loan Name',
                  hintText: 'Enter loan name',
                  controller: _loanNameController,
                  validator: Validators.validateString(),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          AppTextFormField(
            labelText: 'Amount',
            hintText: '#25,000',
            controller: _desiredAmountController,
            validator: Validators.validateString(),
            inputType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            onChanged: (value) {
              double amount = double.tryParse(value) ?? 0;
              _simulateInvestmentCheck(amount);
            },
          ),
          SizedBox(height: 16.h),
          ClickableFormField(
            labelText: 'Tenure',
            hintText: 'Select number of days',
            controller: _tenureController,
            onPressed: _showTenureBottomSheet,
            validator: (value) => value == null || value.isEmpty
                ? 'Please select a tenure'
                : null,
          ),
          SizedBox(height: 16.h),
          ClickableFormField(
            labelText: 'Guarantor',
            hintText: 'Specify guarantor',
            controller: _guarantorController,
            onPressed: _showGuarantorBottomSheet,
            validator: (value) => value == null || value.isEmpty
                ? 'Please select a guarantor'
                : null,
          ),
          SizedBox(height: 16.h),
          if (_guarantorType == 'self')
            Column(
              children: [
                _buildInvestmentAccountInfo(),
              ],
            )
          else if (_guarantorType == 'external')
            Column(
              children: [
                AppTextFormField(
                  labelText: 'Phone Number',
                  hintText: 'Enter your guarantor’s phone number',
                  controller: _phoneNumberController,
                  validator: Validators.validatePhoneNumber(),
                  inputType: TextInputType.phone,
                  onChanged: (value) {
                    _simulateGuarantorCheck(value);
                  },
                ),
                SizedBox(height: 8.h),
                if (_isGuarantor)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Adeyemi Temitope',
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontSize: Insets.dim_12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.appPrimaryColor.withValues(alpha: 0.9),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                else
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Guarantor does not have an active investment',
                      style: context.textTheme.bodySmall!.copyWith(
                        color: Colors.red,
                        fontStyle: FontStyle.italic,
                        fontSize: Insets.dim_12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
              ],
            ),
          SizedBox(height: 26.h),
          AppPrimaryButton(
            textTitle: 'Submit',
            action: () {
              if (_formKey.currentState!.validate()) {
                _submitLoanApplication();
              }
            },
          ),
          SizedBox(height: 26.h),
        ],
      ),
    );
  }

  void _submitLoanApplication() {
    showLoanModal(context);
  }

  void showLoanModal(BuildContext context) {
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
                          'Easi Loan Application Summary',
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
                  // SizedBox(height: 16.h),
                  // _buildLoanDetailRow('Loan Name', _loanNameController.text),
                  SizedBox(height: 16.h),
                  _buildLoanDetailRow(
                      'Loan Amount', '₦${_desiredAmountController.text}'),
                  SizedBox(height: 16.h),
                  _buildLoanDetailRow('Tenure', _tenureController.text),
                  SizedBox(height: 16.h),
                  _buildLoanDetailRow('Interest Rate', '5%'),
                  SizedBox(height: 16.h),
                  _buildLoanDetailRow('Monthly Repayment Amount', '#1200'),
                  SizedBox(height: 16.h),
                  _buildLoanDetailRow('Monthly Repayment Date', '12/12/24'),
                  SizedBox(height: 16.h),
                  _buildLoanDetailRow(
                      'Guarantor Type', _guarantorController.text),
                  // SizedBox(height: 16.h),
                  // _buildLoanDetailRow(
                  //     'Guarantee Investment here', 'Individual'),
                  if (_guarantorType == 'external') ...[
                    SizedBox(height: 16.h),
                    _buildLoanDetailRow(
                      'Guarantor’s Phone Number',
                      _phoneNumberController.text.isNotEmpty
                          ? _phoneNumberController.text
                          : 'Not provided',
                    ),
                  ],
                  SizedBox(height: 24.h),
                  AppPrimaryButton(
                    textTitle: "Confirm",
                    action: () {
                      AppNavigator.of(context).pop();
                      // Navigator.pop(context); // Close the modal
                      _navigateToEasyLoanPin(context, _guarantorType);
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

  void _navigateToEasyLoanPin(BuildContext context, String guarantorType) {
    // context.go(
    //   '${AppRoutes.loans}/easy-loan-pin',
    //   extra: EasyLoanPinArgs(
    //     routeTo: '',
    //     guarantorType: guarantorType,
    //   ),
    // );
    context.go('${AppRoutes.loans}/${AppRoutes.easyLoanPin}');
  }

  Widget _buildLoanDetailRow(String label, String value) {
    if (label == 'Loan Status') {
      switch (value.toLowerCase()) {
        case 'active':
          break;
        case 'overdue':
          break;
        case 'repaid':
          break;
        case 'in review':
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
            //  style: TextStyle(fontSize: 14.sp, color: AppColors.grey)
            style: context.textTheme.bodySmall!.copyWith(
              fontSize: Insets.dim_14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black.withValues(alpha: 0.6),
            ),
          ),
          Text(
            value,
            style: context.textTheme.bodyMedium!.copyWith(
              fontSize: Insets.dim_16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
