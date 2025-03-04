import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/presentation/routes/routes.dart';
import 'package:pinput/pinput.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/security/number_pad_ui/number_pad_ui.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'package:provider/provider.dart';

import '../../../navigation/presentation/navigator.dart';
import '../../../otp/presentation/widget/pin_textfield.dart';

class LoanSuccessModalArgs {
  final String routeTo;

  LoanSuccessModalArgs({required this.routeTo});

  factory LoanSuccessModalArgs.fromMap(Map<String, String> map) {
    return LoanSuccessModalArgs(
      routeTo: map['routeTo'] ?? '',
    );
  }

  // Optional empty constructor
  LoanSuccessModalArgs.empty() : routeTo = '';
}

class LoanSuccessModal extends StatefulWidget {
  const LoanSuccessModal({
    super.key,
    required this.args,
    required this.onPinEntered,
  });

  final LoanSuccessModalArgs args;
  final Function(String) onPinEntered;

  @override
  State<LoanSuccessModal> createState() => _LoanSuccessModalState();
}

class _LoanSuccessModalState extends State<LoanSuccessModal> {
  final TextEditingController _otpTEC = TextEditingController();
  bool _showPassword = false;
  String _defaultValue = '';
  static const int _pinLength = 4;

  void _pinListener() {
    if (mounted) {
      setState(() => _defaultValue = _otpTEC.text);
    }
  }

  @override
  void initState() {
    super.initState();
    _otpTEC.addListener(_pinListener);
  }

  @override
  void dispose() {
    _otpTEC.removeListener(_pinListener);
    _otpTEC.dispose();
    super.dispose();
  }

  void _showSuccessModal() {
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
                  successPng,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Loan Successful',
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: Insets.dim_18.sp,
                  color: AppColors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              AppPrimaryButton(
                textTitle: "Done",
                action: () {
                  widget.onPinEntered(_otpTEC.text);
                  if (widget.args.routeTo.isNotEmpty) {
                    AppNavigator.of(context).push(widget.args.routeTo);
                  } else {
                    AppNavigator.of(context).push(AppRoutes.loans);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(showLeading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter PIN ',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.black.withOpacity(.88),
                  fontSize: 24.sp,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 70.h),
              if (_defaultValue.isNotEmpty)
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.purpleColor.withOpacity(0.1),
                      borderRadius: Corners.smBorder,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        _defaultValue.length,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: _showPassword
                              ? Text(_defaultValue[index])
                              : LocalSvgImage(asterickSvg),
                        ),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 48.h),
              PinTextField(
                numOfDigits: _pinLength,
                onChanged: (input) {},
                controller: _otpTEC,
                obscureText: !_showPassword,
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Enter your $_pinLength-digit PIN',
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.black.withOpacity(.88),
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(width: 16.w),
                  GestureDetector(
                    onTap: () => setState(() => _showPassword = !_showPassword),
                    child: Icon(
                      _showPassword
                          ? PhosphorIcons.eyeSlash(PhosphorIconsStyle.bold)
                          : PhosphorIcons.eye(PhosphorIconsStyle.bold),
                      color: AppColors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 66.h),
              NumberPadUi(
                key: const Key('numberPadUi'),
                isForAuth: true,
                maxLength: _pinLength,
                defaultValue: _defaultValue,
                onChanged: _otpTEC.setText,
                onDelete: _otpTEC.delete,
              ),
              SizedBox(height: 34.h),
              AppButton(
                textTitle: 'Confirm',
                action: _showSuccessModal,
              ),
              SizedBox(height: 34.h),
            ],
          ),
        ),
      ),
    );
  }
}
