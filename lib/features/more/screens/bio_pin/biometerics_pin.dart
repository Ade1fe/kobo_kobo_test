import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kobo_kobo/features/loans/screen/salary_loan_screen.dart';
import 'package:kobo_kobo/features/transfer/transfer.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/security/number_pad_ui/number_pad_ui.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../otp/presentation/widget/pin_textfield.dart';

class BiometericsPinArgs {
  final String routeTo;

  BiometericsPinArgs({required this.routeTo});
  factory BiometericsPinArgs.empty() {
    return BiometericsPinArgs(
      routeTo: '',
    );
  }
}

class BiometericsPin extends StatefulWidget {
  const BiometericsPin({
    super.key,
    required this.args,
    required this.onPinEntered,
  });

  final BiometericsPinArgs args;
  final Function(String) onPinEntered;

  @override
  State<BiometericsPin> createState() => _BiometericsPinState();
}

class _BiometericsPinState extends State<BiometericsPin> {
  final TextEditingController _otpTEC = TextEditingController();
  bool _showPassword = false;
  String _defaultValue = '';

  void _pinListener() {
    if (mounted) {
      setState(() => _defaultValue = _otpTEC.text);
    }
  }

  void _showSuccessModal(BuildContext context) {
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
                'Your biometrics have been saved',
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
                  Navigator.pop(context);
                  widget.onPinEntered(_otpTEC.text);
                  Navigator.pop(context);
                  if (widget.args.routeTo.isNotEmpty) {
                    Navigator.pushNamed(context, widget.args.routeTo);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/more', (route) => false);
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

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TransferVm>();
    return AppScaffoldWidget(
      appBar: const CustomAppBar(showLeading: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Enter PIN',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.black.withOpacity(.88),
                  fontSize: 24.sp,
                ),
              ),
            ),
            YBox(10.h),
            Center(
              child: Text(
                'Enter your PIN to enable biometrics',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.black.withOpacity(.88),
                  fontSize: 16.sp,
                ),
              ),
            ),
            YBox(30.h),
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
                        child: LocalSvgImage(asterickSvg),
                      ),
                    ),
                  ),
                ),
              ),
            YBox(38.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.w),
              child: PinTextField(
                numOfDigits: 4,
                controller: _otpTEC,
                obscureText: !_showPassword,
                onChanged: (input) {},
              ),
            ),
            YBox(24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enter your 4-digit PIN',
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withOpacity(.88),
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.start,
                ),
                XBox(16.w),
                Icon(
                  _showPassword
                      ? PhosphorIcons.eyeSlash(PhosphorIconsStyle.bold)
                      : PhosphorIcons.eye(PhosphorIconsStyle.bold),
                  color: AppColors.black.withOpacity(0.5),
                ).onTap(() => setState(() => _showPassword = !_showPassword)),
              ],
            ),
            YBox(66.h),
            NumberPadUi(
              isForAuth: true,
              maxLength: 4,
              defaultValue: _defaultValue,
              onChanged: _otpTEC.setText,
              onDelete: _otpTEC.delete,
            ),
            YBox(34.h),
            AppButton(
              textTitle: 'Confirm',
              action: () {
                if (_otpTEC.text.length == 4) {
                  _showSuccessModal(context);
                }
              },
            ),
            YBox(34.h),
          ],
        ),
      ),
    );
  }
}
