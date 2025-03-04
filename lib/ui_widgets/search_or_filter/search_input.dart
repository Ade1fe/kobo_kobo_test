import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

import 'package:flutter/material.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

List<String> lookUp(String query, List<String> list) {
  if (query.isEmpty) return list;
  return list
      .where(
        (data) => data.toLowerCase().contains(query.toLowerCase()),
      )
      .toList();
}

dynamic occupationLookUp(String query, dynamic list) {
  if (query.isEmpty) return list;
  return list
      .where(
        (data) => data.description.toLowerCase().contains(query.toLowerCase()),
      )
      .toList();
}

class SearchTextInputField extends StatelessWidget {
  const SearchTextInputField({
    this.title = 'Search ',
    this.showLeading = true,
    this.onChanged,
    this.controller,
    this.validator,
    this.labelText,
    super.key,
    this.suffixIcon,
  });
  final bool showLeading;
  final String title;
  final String? labelText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? Function(String? input)? validator;

  @override
  Widget build(BuildContext context) {
    final genericDecoration = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.borderColor,
      ),
      borderRadius: Corners.lgBorder,
    );
    return AppTextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      hintText: title,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        hintText: title,
        hintStyle: context.textTheme.bodySmall!.copyWith(
          color: AppColors.black.withOpacity(0.4),
          fontSize: Insets.dim_16.sp,
        ),
        constraints: BoxConstraints(maxHeight: Insets.dim_44.h),
        contentPadding:
            EdgeInsets.symmetric(horizontal: showLeading ? 14.0 : 16.0),
        prefixIcon: showLeading
            ? Icon(
                PhosphorIcons.magnifyingGlass(),
                color: AppColors.black.withOpacity(0.4),
                size: 20,
              )
            : null,
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
    );
  }
}
