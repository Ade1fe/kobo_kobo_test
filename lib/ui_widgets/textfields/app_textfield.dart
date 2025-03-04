import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/core/data/core_data.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.labelText,
    this.prefixText,
    this.initialValue,
    this.style,
    this.suffixIcon,
    this.inputType,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.maxLines = 1,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.enableInteractiveSelection = true,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.enabled = true,
    this.showAsterisk = false,
    this.labelStyle,
    this.hintStyle,
    this.isLoading = false,
    this.readOnly = false,
    this.suffixText,
    this.decoration,
    this.autoValidateMode,
  });
  final String? labelText, prefixText;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final String? Function(String? input)? validator;
  final Function(String input)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final String? hintText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final bool enableInteractiveSelection;
  final bool? obscureText;
  final bool enabled;
  final bool readOnly;
  final bool isLoading;
  final bool showAsterisk;
  final String? suffixText;
  final InputDecoration? decoration;
  final AutovalidateMode? autoValidateMode;

  @override
  Widget build(BuildContext context) {
    final genericDecoration = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.borderColor,
      ),
      borderRadius: Corners.xsBorder,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  labelText!,
                  style: labelStyle ??
                      context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.black,
                        fontSize: Insets.dim_16.sp,
                      ),
                ),
              ),
              const XBox(Insets.dim_4),
              Visibility(
                visible: showAsterisk,
                child: const Text(
                  '*',
                  style: TextStyle(
                    color: AppColors.borderErrorColor,
                    fontSize: Insets.dim_12,
                  ),
                ),
              ),
            ],
          ),
          if (!showAsterisk) const YBox(Insets.dim_6),
        ],
        IgnorePointer(
          ignoring: isLoading,
          child: SizedBox(
            // width: context.getWidth(0.9.w),
            child: TextFormField(
              controller: controller,
              cursorColor: AppColors.black,
              onSaved: (input) => onSaved?.call((input ?? '').trim()),
              autovalidateMode: autoValidateMode,
              onEditingComplete: onEditingComplete,
              obscureText: obscureText!,
              enableInteractiveSelection: enableInteractiveSelection,
              maxLines: maxLines,
              focusNode: focusNode,
              inputFormatters: inputFormatters,
              initialValue: initialValue,
              keyboardType: inputType,
              textAlign: textAlign,
              enabled: enabled,
              readOnly: readOnly,
              style: style ??
                  context.textTheme.bodySmall!.copyWith(
                    color: AppColors.black,
                    fontSize: Insets.dim_14.sp,
                    fontWeight: FontWeight.w400,
                  ),
              decoration: decoration ??
                  InputDecoration(
                    suffixStyle: const TextStyle(
                      color: AppColors.appPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    suffixText: suffixText,
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon,
                    hintText: hintText,
                    prefixText: prefixText,
                    labelStyle: labelStyle,
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: hintStyle ??
                        context.textTheme.bodySmall!.copyWith(
                          color: AppColors.black.withOpacity(0.5),
                          fontSize: Insets.dim_14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: Insets.dim_16,
                      vertical: maxLines == 1 ? 4.0 : 16.0,
                    ),
                    border: genericDecoration,
                    enabledBorder: genericDecoration,
                    focusedBorder: genericDecoration.copyWith(
                      borderSide: const BorderSide(
                        width: 1.3,
                        color: AppColors.appPrimaryColor,
                      ),
                    ),
                    focusedErrorBorder: genericDecoration.copyWith(
                      borderSide: const BorderSide(
                        width: 1.3,
                        color: AppColors.borderErrorColor,
                      ),
                    ),
                    errorBorder: genericDecoration.copyWith(
                      borderSide: const BorderSide(
                        width: 1.3,
                        color: AppColors.borderErrorColor,
                      ),
                    ),
                  ),
              onChanged: onChanged,
              validator: validator,
            ),
          ),
        ),
      ],
    );
  }
}

class ClickableFormField extends StatelessWidget {
  const ClickableFormField({
    super.key,
    this.labelText,
    this.initialValue,
    this.suffixIcon,
    this.inputType,
    this.onChanged,
    this.onEditingComplete,
    this.onPressed,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.maxLines = 1,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.enableInteractiveSelection = true,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.showAsterisk = false,
    this.enabled = true,
    this.readonly = true,
    this.labelStyle,
    this.hintStyle,
    TextStyle? style,
  });
  final String? labelText;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final String? Function(String? input)? validator;
  final Function(String input)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final Function()? onPressed;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final FocusNode? focusNode;
  final bool enableInteractiveSelection;
  final TextAlign textAlign;
  final String? hintText;
  final bool? obscureText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool enabled;
  final bool readonly;
  final bool showAsterisk;

  final TextStyle? labelStyle;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      hintText: hintText,
      labelText: labelText,
      initialValue: initialValue,
      showAsterisk: showAsterisk,
      prefixIcon: prefixIcon,
      suffixIcon: InkWell(
        onTap: onPressed,
        child: suffixIcon ??
            Icon(
              PhosphorIcons.caretDown(),
              size: 18,
              color: AppColors.black.withOpacity(0.8),
            ),
      ),
      inputType: inputType,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSaved: onSaved,
      validator: validator,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      readOnly: readonly,
      focusNode: focusNode,
      textAlign: textAlign,
      obscureText: obscureText,
      enableInteractiveSelection: enableInteractiveSelection,
      controller: controller,
      enabled: enabled,
      labelStyle: labelStyle,
      hintStyle: hintStyle,
    );
  }
}

class PhoneNumberTextFormField extends StatefulWidget {
  const PhoneNumberTextFormField({
    super.key,
    this.labelText,
    this.initialValue,
    this.textFieldIcon,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.enableInteractiveSelection = true,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.enabled = true,
    this.labelStyle,
    this.style,
    this.showCountryList = true,
    this.phoneNumberCountry,
  });
  final String? labelText;
  final PhoneNumber? initialValue;
  final Widget? textFieldIcon;
  final Function(String input)? onChanged;
  final Function(PhoneNumber?)? onSaved;
  final Function()? onEditingComplete;
  final FocusNode? focusNode;
  final bool enableInteractiveSelection;
  final TextAlign textAlign;
  final String? hintText;
  final bool? obscureText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool enabled;
  final bool showCountryList;
  final TextStyle? labelStyle, style;
  final CountryData? phoneNumberCountry;

  @override
  State<PhoneNumberTextFormField> createState() =>
      _PhoneNumberTextFormFieldState();
}

class _PhoneNumberTextFormFieldState extends State<PhoneNumberTextFormField> {
  late CountryData phoneNumberCountry;
  @override
  void initState() {
    super.initState();
    phoneNumberCountry =
        widget.phoneNumberCountry ?? phoneNumberCountryList()[0];
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      style: widget.style,
      prefixIcon: SizedBox(
        height: 40,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const XBox(Insets.dim_8),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: LocalSvgImage(phoneNumberCountry.flag),
            ),
            const XBox(Insets.dim_4),
            Text(phoneNumberCountry.mobileCountryCode),
            const XBox(Insets.dim_4),
            Icon(
              PhosphorIcons.caretDown(),
              size: 18,
              color: AppColors.black,
            ),
            const XBox(Insets.dim_4),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: Insets.dim_14),
              child: VerticalDivider(width: 0, thickness: 1.5),
            ),
            const XBox(Insets.dim_10),
          ],
        ),
      ).onTap(() async {
        if (!widget.showCountryList) return;
        final country = await FutureListBottomSheet<CountryData>(
          title: 'Select country',
          future: () => Future.value(phoneNumberCountryList()),
          itemBuilder: (context, item) {
            return ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(top: Insets.dim_4),
                child: LocalSvgImage(item.flag),
              ),
              title: Text('(${item.mobileCountryCode}) ${item.countryName}'),
            );
          },
        ).show(context);
        if (country != null) {
          setState(() {
            phoneNumberCountry = country;
          });
        }
      }),
      labelText: widget.labelText ?? 'Phone Number',
      hintText: widget.hintText ?? 'Enter phone number',
      initialValue: widget.initialValue?.number,
      suffixIcon: widget.textFieldIcon,
      inputType: TextInputType.number,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onSaved: (input) => widget.onSaved?.call(
        PhoneNumber(
          number: '$input',
          dialCode: phoneNumberCountry.mobileCountryCode,
        ),
      ),
      validator: (input) => Validators.validatePhoneNumber(
        maxLength: phoneNumberCountry.maxLength,
      )(input),
      inputFormatters: [
        LengthLimitingTextInputFormatter(phoneNumberCountry.maxLength),
        FilteringTextInputFormatter.digitsOnly,
      ],
      focusNode: widget.focusNode,
      textAlign: widget.textAlign,
      obscureText: widget.obscureText,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      controller: widget.controller,
      enabled: widget.enabled,
      labelStyle: widget.labelStyle,
    );
  }
}

InputDecoration getDropDownButtonDecoration({
  String? labelText,
  String? hintText,
  Widget? prefixIcon,
  Widget? textFieldIcon,
  double radius = 4.0,
}) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    suffixIcon: textFieldIcon,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.borderColor,
      ),
      borderRadius: Corners.smBorder,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.borderColor,
      ),
      borderRadius: Corners.smBorder,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.borderColor,
      ),
      borderRadius: Corners.smBorder,
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.3,
        color: Colors.red,
      ),
      borderRadius: Corners.smBorder,
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.scaffold,
      ),
      borderRadius: Corners.smBorder,
    ),
    hintText: hintText,
    labelText: labelText,
  );
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    super.key,
    Widget? title,
    super.onSaved,
    super.validator,
    bool super.initialValue = false,
    required Function({bool? value})? onChanged,
    required BuildContext context,
  }) : super(
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
              dense: state.hasError,
              title: title,
              value: state.value,
              onChanged: (value) => onChanged?.call(value: value),
              activeColor: Theme.of(context).primaryColor,
              shape: const RoundedRectangleBorder(
                borderRadius: Corners.rsBorder,
              ),
              checkboxShape: const RoundedRectangleBorder(
                borderRadius: Corners.rsBorder,
              ),
              subtitle: state.hasError
                  ? Builder(
                      builder: (BuildContext context) => Text(
                        state.errorText ?? '',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    )
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        );
}
