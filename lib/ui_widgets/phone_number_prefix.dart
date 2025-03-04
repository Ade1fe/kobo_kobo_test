import 'package:flutter/material.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class PhoneNumberPrefix extends StatelessWidget {
  const PhoneNumberPrefix({
    super.key,
    this.flag,
    this.dialCode,
    this.showDropdown = false,
  });

  final String? flag, dialCode;
  final bool? showDropdown;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          LocalSvgImage(
            flag!, // Make sure flag is not null
            height: 20,
            width: 25,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            dialCode ?? '', // Ensure dialCode is not null
            style: const TextStyle(fontSize: 13),
          ),
          Offstage(
            offstage: !showDropdown!,
            child: const Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 18,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
