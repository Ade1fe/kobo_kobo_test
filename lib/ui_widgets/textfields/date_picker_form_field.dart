import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kobo_kobo/ui_widgets/constants/constants.dart';
import 'package:kobo_kobo/ui_widgets/textfields/app_textfield.dart';

class DatePickerFormField extends StatelessWidget {
  const DatePickerFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.onChanged,
    this.controller,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.textStyle,
    this.style, // Add this line
  });

  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? textStyle; // Optional style
  final TextStyle? style; // Add this line

  @override
  Widget build(BuildContext context) {
    return ClickableFormField(
      labelText: labelText,
      hintText: hintText ?? 'Select a date',
      initialValue: initialValue,
      onChanged: onChanged,
      controller: controller,
      onSaved: onSaved,
      validator: validator,
      inputFormatters: inputFormatters,
      style: style, // Add this line
      suffixIcon: InkWell(
        onTap: () async {
          DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (selectedDate != null) {
            final formattedDate = "${selectedDate.toLocal()}".split(' ')[0]; 
            controller?.text = formattedDate;
            onChanged?.call(formattedDate);
          }
        },
        child: Icon(
          Icons.calendar_today,
          color: AppColors.black.withOpacity(0.8),
        ),
      ),
    );
  }
}

