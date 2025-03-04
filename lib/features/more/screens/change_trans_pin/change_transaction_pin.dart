import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../otp/presentation/widget/pin_textfield.dart';

class ChangeTransactionPin extends StatefulWidget {
  const ChangeTransactionPin({super.key});

  @override
  _ChangeTransactionPinState createState() => _ChangeTransactionPinState();
}

class _ChangeTransactionPinState extends State<ChangeTransactionPin> {
  final TextEditingController _oldPinController = TextEditingController();
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isNewPinVisible = false;
  bool _isConfirmPinVisible = false;

  String _passwordError = '';
  String _pinError = '';

  static const int _pinLength = 4;
  static const int _passwordLength = 4;

  @override
  void initState() {
    super.initState();
    _oldPinController.addListener(_updateState);
    _newPinController.addListener(_updateState);
    _confirmPinController.addListener(_updateState);
  }

  @override
  void dispose() {
    _oldPinController.removeListener(_updateState);
    _newPinController.removeListener(_updateState);
    _confirmPinController.removeListener(_updateState);

    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  void _toggleVisibility(String field) {
    setState(() {
      switch (field) {
        case 'password':
          _isPasswordVisible = !_isPasswordVisible;
          break;
        case 'newPin':
          _isNewPinVisible = !_isNewPinVisible;
          break;
        case 'confirmPin':
          _isConfirmPinVisible = !_isConfirmPinVisible;
          break;
      }
    });
  }

  void _validateInputs() {
    setState(() {
      _passwordError = _oldPinController.text.length != _passwordLength
          ? 'PIN must be $_passwordLength digits'
          : '';
      _pinError = _newPinController.text != _confirmPinController.text
          ? 'PINs do not match'
          : '';
    });
  }

// showInfoNotification

  void showTopSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0,
        left: 0.0,
        right: 0.0,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      PhosphorIcons.checkCircle(),
                      size: 24.sp,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      // overlayEntry.remove();
                    },
                  ),
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      PhosphorIcons.xCircle(),
                      size: 24.sp,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      // overlayEntry.remove();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Change Transaction PIN',
                  style: context.textTheme.bodySmall!.copyWith(
                    fontSize: Insets.dim_24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                const Divider(height: 1, thickness: 1.0),
                SizedBox(height: 20.h),
                Align(
                  child: Text(
                    'Enter your new 4-digit PIN below.',
                    // style: TextStyle(fontSize: 16.sp),
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontSize: Insets.dim_16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 52.h),
                _buildInputSection(
                  label: 'Old Transaction PIN',
                  controller: _oldPinController,
                  isInputVisible: _isPasswordVisible,
                  toggleVisibility: () => _toggleVisibility('password'),
                  error: _passwordError,
                  length: _passwordLength,
                ),
                SizedBox(height: 44.h),
                _buildInputSection(
                  label: 'New Transaction PIN',
                  controller: _newPinController,
                  isInputVisible: _isNewPinVisible,
                  toggleVisibility: () => _toggleVisibility('newPin'),
                  length: _pinLength,
                ),
                SizedBox(height: 44.h),
                _buildInputSection(
                  label: 'Confirm New Transaction PIN',
                  controller: _confirmPinController,
                  isInputVisible: _isConfirmPinVisible,
                  toggleVisibility: () => _toggleVisibility('confirmPin'),
                  error: _pinError,
                  length: _pinLength,
                ),
                SizedBox(height: 44.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: AppPrimaryButton(
                    action: () {
                      _validateInputs();
                      if (_passwordError.isEmpty && _pinError.isEmpty) {
                        showTopSnackBar(
                            context, 'Transaction PIN Change Successful');
                      }
                    },
                    textTitle: 'Save',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection({
    required String label,
    required TextEditingController controller,
    required bool isInputVisible,
    required VoidCallback toggleVisibility,
    String? error,
    required int length,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          child: Text(label,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 60.h,
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    PinTextField(
                      numOfDigits: length,
                      controller: controller,
                      obscureText: !isInputVisible,
                    ),
                    Positioned.fill(
                      child: IgnorePointer(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            length,
                            (index) => Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  isInputVisible ||
                                          controller.text.length <= index
                                      ? ''
                                      : '*',
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isInputVisible
                      ? PhosphorIcons.eye()
                      : PhosphorIcons.eyeSlash(),
                  size: 24.sp,
                  color: Colors.grey[600],
                ),
                onPressed: toggleVisibility,
              ),
            ],
          ),
        ),
        if (error?.isNotEmpty ?? false)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Align(
              child: Text(
                error!,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.red[700],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
