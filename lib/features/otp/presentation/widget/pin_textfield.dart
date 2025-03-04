import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:pinput/pinput.dart';

class PinTextField extends StatefulWidget {
  const PinTextField({
    this.numOfDigits = 6,
    this.keyboardType = TextInputType.number,
    this.obscureText = false,
    this.onSaved,
    this.onChanged,
    this.controller,
    this.validator,
    this.otpError,
    this.enabled = true,
    super.key,
  });
  final int numOfDigits;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final TextEditingController? controller;
  final String? Function(String? input)? validator;
  final TextInputType keyboardType;
  final String? otpError;
  final bool obscureText;
  final bool enabled;

  @override
  State<PinTextField> createState() => _PinTextFieldState();
}

class _PinTextFieldState extends State<PinTextField> {
  bool isPinNotValid = false;

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: context.getWidth(),
      height: context.getHeight(.05),
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColors.appPrimaryColor.withOpacity(0.7), width: 0.8),
        borderRadius: Corners.smBorder,
        color: AppColors.white,
      ),
      textStyle: context.textTheme.bodySmall!.copyWith(
        color: AppColors.black.withValues(alpha: 0.6),
        fontSize: Insets.dim_14.sp,
        fontWeight: FontWeight.w500,
      ),
    );

    return Theme(
      data: ThemeData(
        inputDecorationTheme:
            const InputDecorationTheme(border: InputBorder.none),
      ),
      child: Pinput(
        obscureText: widget.obscureText,
        enabled: widget.enabled,
        length: widget.numOfDigits,
        keyboardType: widget.keyboardType,
        onCompleted: widget.onSaved,
        onChanged: widget.onChanged,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.numOfDigits),
          FilteringTextInputFormatter.digitsOnly,
        ],
        controller: widget.controller,
        submittedPinTheme: defaultTheme.copyDecorationWith(
          border: Border.all(
            color: isPinNotValid
                ? Colors.red
                : AppColors.appPrimaryColor.withOpacity(0.70),
          ),
        ),
        followingPinTheme: defaultTheme.copyDecorationWith(
          border: Border.all(
            color: isPinNotValid
                ? Colors.red
                : AppColors.appPrimaryColor.withOpacity(0.70),
          ),
        ),
        focusedPinTheme: defaultTheme,
        validator: (input) {
          setState(() {
            if (input == null ||
                input.isEmpty ||
                input.length < widget.numOfDigits) {
              isPinNotValid = true;
            } else {
              isPinNotValid = false;
            }
          });
          return widget.validator?.call(input);
        },
      ),
    );
  }
}
