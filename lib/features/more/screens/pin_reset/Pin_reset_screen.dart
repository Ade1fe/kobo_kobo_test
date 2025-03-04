// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kobo_kobo/functional_util/functional_utils.dart';
// import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import '../../../otp/presentation/widget/pin_textfield.dart';

// class PinResetScreen extends StatefulWidget {
//   const PinResetScreen({super.key});

//   @override
//   _PinResetScreenState createState() => _PinResetScreenState();
// }

// class _PinResetScreenState extends State<PinResetScreen> {
//   final _passwordController = TextEditingController();
//   final _newPinController = TextEditingController();
//   final _confirmPinController = TextEditingController();

//   String _passwordError = '';
//   String _pinError = '';

//   bool _isPasswordVisible = false;
//   bool _isNewPinVisible = false;
//   bool _isConfirmPinVisible = false;

//   final int _passwordLength = 6;
//   final int _pinLength = 4;

//   void _toggleVisibility(String type) {
//     setState(() {
//       switch (type) {
//         case 'password':
//           _isPasswordVisible = !_isPasswordVisible;
//           break;
//         case 'newPin':
//           _isNewPinVisible = !_isNewPinVisible;
//           break;
//         case 'confirmPin':
//           _isConfirmPinVisible = !_isConfirmPinVisible;
//           break;
//       }
//     });
//   }

//   void _validateInputs() {
//     setState(() {
//       _passwordError = _passwordController.text.length < _passwordLength
//           ? 'Password must be at least $_passwordLength characters'
//           : '';
//       if (_newPinController.text.length != _pinLength) {
//         _pinError = 'PIN must be $_pinLength digits';
//       } else if (_newPinController.text != _confirmPinController.text) {
//         _pinError = 'PINs do not match';
//       } else {
//         _pinError = '';
//       }
//     });
//   }

//   void showTopSnackBar(BuildContext context, String message) {
//     final overlay = Overlay.of(context);
//     late OverlayEntry overlayEntry;

//     overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: 50.0,
//         left: 0.0,
//         right: 0.0,
//         child: Material(
//           color: Colors.transparent,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//               decoration: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     PhosphorIcons.checkCircle(),
//                     size: 24.sp,
//                     color: Colors.white,
//                   ),
//                   SizedBox(width: 12.w),
//                   Expanded(
//                     child: Text(
//                       message,
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       PhosphorIcons.xCircle(),
//                       size: 24.sp,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       overlayEntry.remove();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );

//     overlay.insert(overlayEntry);

//     Future.delayed(const Duration(seconds: 3), () {
//       overlayEntry.remove();
//     });
//   }

//   Widget _buildPasswordField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Password',
//           style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
//         ),
//         SizedBox(height: 8.h),
//         TextFormField(
//           controller: _passwordController,
//           obscureText: !_isPasswordVisible,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.r),
//             ),
//             suffixIcon: IconButton(
//               icon: Icon(
//                 _isPasswordVisible
//                     ? PhosphorIcons.eye()
//                     : PhosphorIcons.eyeSlash(),
//                 size: 24.sp,
//                 color: Colors.grey[600],
//               ),
//               onPressed: () => _toggleVisibility('password'),
//             ),
//           ),
//           style: TextStyle(fontSize: 20.sp),
//         ),
//         if (_passwordError.isNotEmpty)
//           Padding(
//             padding: EdgeInsets.only(top: 8.h),
//             child: Text(
//               _passwordError,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.red[700],
//                 fontStyle: FontStyle.italic,
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildPinField({
//     required String label,
//     required TextEditingController controller,
//     required bool isVisible,
//     required VoidCallback toggleVisibility,
//     String? error,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
//         ),
//         SizedBox(height: 8.h),
//         SizedBox(
//           height: 60.h,
//           child: Row(
//             children: [
//               Expanded(
//                 child: PinTextField(
//                   numOfDigits: _pinLength,
//                   controller: controller,
//                   obscureText: !isVisible,
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(
//                   isVisible ? PhosphorIcons.eye() : PhosphorIcons.eyeSlash(),
//                   size: 24.sp,
//                   color: Colors.grey[600],
//                 ),
//                 onPressed: toggleVisibility,
//               ),
//             ],
//           ),
//         ),
//         if (error != null && error.isNotEmpty)
//           Padding(
//             padding: EdgeInsets.only(top: 8.h),
//             child: Text(
//               error,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.red[700],
//                 fontStyle: FontStyle.italic,
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   bool _isFormValid() {
//     return _passwordController.text.length >= _passwordLength &&
//         _newPinController.text.length == _pinLength &&
//         _confirmPinController.text.length == _pinLength &&
//         _newPinController.text == _confirmPinController.text;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AppScaffoldWidget(
//       appBar: const CustomAppBar(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'PIN Reset',
//                   style: context.textTheme.bodySmall!.copyWith(
//                     fontSize: Insets.dim_24.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 12.h),
//                 const Divider(height: 1, thickness: 1.0),
//                 SizedBox(height: 20.h),
//                 Text(
//                   'Enter your password followed by your new PIN.',
//                   // style: TextStyle(fontSize: 16.sp),
//                   style: context.textTheme.bodySmall!.copyWith(
//                     fontSize: Insets.dim_16.sp,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.black,
//                   ),
//                 ),
//                 SizedBox(height: 32.h),
//                 _buildPasswordField(),
//                 SizedBox(height: 24.h),
//                 _buildPinField(
//                   label: 'New PIN',
//                   controller: _newPinController,
//                   isVisible: _isNewPinVisible,
//                   toggleVisibility: () => _toggleVisibility('newPin'),
//                 ),
//                 SizedBox(height: 24.h),
//                 _buildPinField(
//                   label: 'Confirm New PIN',
//                   controller: _confirmPinController,
//                   isVisible: _isConfirmPinVisible,
//                   toggleVisibility: () => _toggleVisibility('confirmPin'),
//                   error: _pinError,
//                 ),
//                 SizedBox(height: 32.h),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50.h,
//                   child: AppPrimaryButton(
//                     action: () {
//                       if (_isFormValid()) {
//                         showTopSnackBar(context, 'PIN Reset Successful');
//                       } else {
//                         _validateInputs();
//                         setState(() {});
//                       }
//                     },
//                     textTitle: 'Send',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _passwordController.dispose();
//     _newPinController.dispose();
//     _confirmPinController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../otp/presentation/widget/pin_textfield.dart';

class PinResetScreen extends StatefulWidget {
  const PinResetScreen({super.key});

  @override
  _PinResetScreenState createState() => _PinResetScreenState();
}

class _PinResetScreenState extends State<PinResetScreen> {
  final _passwordController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  String _passwordError = '';
  String _pinError = '';

  bool _isPasswordVisible = false;
  bool _isNewPinVisible = false;
  bool _isConfirmPinVisible = false;

  final int _passwordLength = 6;
  final int _pinLength = 4;

  void _toggleVisibility(String type) {
    setState(() {
      switch (type) {
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
      _passwordError = _passwordController.text.length < _passwordLength
          ? 'Password must be at least $_passwordLength characters'
          : '';
      if (_newPinController.text.length != _pinLength) {
        _pinError = 'PIN must be $_pinLength digits';
      } else if (_newPinController.text != _confirmPinController.text) {
        _pinError = 'PINs do not match';
      } else {
        _pinError = '';
      }
    });
  }

  void showTopSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0,
        left: 0.0,
        right: 0.0,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    PhosphorIcons.checkCircle(),
                    size: 24.sp,
                    color: Colors.white,
                  ),
                  SizedBox(width: 12.w),
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
                      color: Colors.white,
                    ),
                    onPressed: () {
                      overlayEntry.remove();
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

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          // style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          style: context.textTheme.bodySmall!.copyWith(
            fontSize: Insets.dim_16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? PhosphorIcons.eye()
                    : PhosphorIcons.eyeSlash(),
                size: 24.sp,
                color: Colors.grey[600],
              ),
              onPressed: () => _toggleVisibility('password'),
            ),
          ),
          style: TextStyle(fontSize: 20.sp),
        ),
        if (_passwordError.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              _passwordError,
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: Insets.dim_14.sp,
                color: Colors.red[700],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPinField({
    required String label,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback toggleVisibility,
    String? error,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          // style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          style: context.textTheme.bodySmall!.copyWith(
            fontSize: Insets.dim_16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 60.h,
          child: Row(
            children: [
              Expanded(
                child: PinTextField(
                  numOfDigits: _pinLength,
                  controller: controller,
                  obscureText: !isVisible,
                ),
              ),
              IconButton(
                icon: Icon(
                  isVisible ? PhosphorIcons.eye() : PhosphorIcons.eyeSlash(),
                  size: 24.sp,
                  color: Colors.grey[600],
                ),
                onPressed: toggleVisibility,
              ),
            ],
          ),
        ),
        if (error != null && error.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              error,
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: Insets.dim_14.sp,
                color: Colors.red[700],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }

  bool _isFormValid() {
    return _passwordController.text.length >= _passwordLength &&
        _newPinController.text.length == _pinLength &&
        _confirmPinController.text.length == _pinLength &&
        _newPinController.text == _confirmPinController.text;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(1.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'PIN Reset',
                  style: context.textTheme.bodySmall!.copyWith(
                    fontSize: Insets.dim_24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                const Divider(height: 1, thickness: 1.0),
                SizedBox(height: 20.h),
                Text(
                  'Enter your password followed by your new PIN.',
                  // style: TextStyle(fontSize: 16.sp),
                  style: context.textTheme.bodySmall!.copyWith(
                    fontSize: Insets.dim_16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 32.h),
                _buildPasswordField(),
                SizedBox(height: 24.h),
                _buildPinField(
                  label: 'New PIN',
                  controller: _newPinController,
                  isVisible: _isNewPinVisible,
                  toggleVisibility: () => _toggleVisibility('newPin'),
                ),
                SizedBox(height: 24.h),
                _buildPinField(
                  label: 'Confirm New PIN',
                  controller: _confirmPinController,
                  isVisible: _isConfirmPinVisible,
                  toggleVisibility: () => _toggleVisibility('confirmPin'),
                  error: _pinError,
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: AppPrimaryButton(
                    action: () {
                      if (_isFormValid()) {
                        showTopSnackBar(context, 'PIN Reset Successful');
                      } else {
                        _validateInputs();
                        setState(() {});
                      }
                    },
                    textTitle: 'Send',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }
}
