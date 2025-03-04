import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberPadBtnWidget extends StatefulWidget {
  const NumberPadBtnWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final VoidCallback onPressed;

  @override
  State<NumberPadBtnWidget> createState() => _NumberPadBtnWidgetState();
}

class _NumberPadBtnWidgetState extends State<NumberPadBtnWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 70,
      minWidth: 70,
      padding: const EdgeInsets.only(
        //So the text will be properly centered
        top: 4,
      ),
      color: const Color(0xffF0F2F5),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      highlightElevation: 0,
      focusElevation: 0,
      shape: const CircleBorder(),
      onPressed: () {
        HapticFeedback.lightImpact();
        widget.onPressed();
      },
      child: Text(
        widget.text,
        style: const TextStyle(
          fontSize: 24,
          color: Color(0xff374B58),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
