import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/features/otp/otp.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/security/number_pad_ui/number_pad_ui.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pinput/pinput.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  TextEditingController pinTEC = TextEditingController();
  final _otpTEC = TextEditingController();
  bool _showPassword = false;

  String _defaultValue = '';

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
    _otpTEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(
        centerTitle: true,
        showLeading: true,
        useSmallFont: true,
        title: '3/3',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${pinTEC.text.isEmpty ? 'Create' : 'Confirm'} your PIN',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.black.withOpacity(.88),
                fontSize: Insets.dim_24.sp,
              ),
              textAlign: TextAlign.start,
            ),
            YBox(Insets.dim_70.h),
            if (_defaultValue.isNotEmpty)
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Insets.dim_6.w,
                    vertical: Insets.dim_4.h,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: Insets.dim_4.w),
                        child: LocalSvgImage(asterickSvg),
                      ),
                    ),
                  ),
                ),
              ),
            YBox(Insets.dim_48.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.dim_48.w),
              child: PinTextField(
                numOfDigits: 4,
                onChanged: (input) {},
                controller: _otpTEC,
              ),
            ),
            YBox(Insets.dim_24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enter your 4-digit PIN',
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withOpacity(.88),
                    fontSize: Insets.dim_14.sp,
                  ),
                  textAlign: TextAlign.start,
                ),
                XBox(Insets.dim_16.w),
                Icon(
                  _showPassword
                      ? PhosphorIcons.eyeSlash(PhosphorIconsStyle.bold)
                      : PhosphorIcons.eye(PhosphorIconsStyle.bold),
                  color: AppColors.black.withOpacity(0.5),
                ).onTap(() => setState(() => _showPassword = !_showPassword)),
              ],
            ),
            YBox(Insets.dim_66.h),
            NumberPadUi(
              isForAuth: true,
              maxLength: 4,
              defaultValue: _defaultValue,
              onChanged: _otpTEC.setText,
              onDelete: _otpTEC.delete,
            ),
            YBox(Insets.dim_34.h),
            AppButton(
              textTitle: pinTEC.text.isEmpty ? 'Continue' : 'Submit',
              action: () {
                String temp = '';
                if (_otpTEC.text.length == 4 && pinTEC.text.isEmpty) {
                  temp = _otpTEC.text;
                  _otpTEC.clear();
                  _defaultValue = '';
                  pinTEC.text = temp;
                } else if (pinTEC.text.isNotEmpty) {
                  AppNavigator.of(context).push(AppRoutes.reasonForKobo);
                }
                setState(() {});
              },
            ),
            YBox(Insets.dim_34.h),
          ],
        ),
      ),
    );
  }
}
