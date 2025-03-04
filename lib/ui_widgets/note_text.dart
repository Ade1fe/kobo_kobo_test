import 'package:flutter/material.dart';

class NoteText extends StatelessWidget {
  const NoteText(this.text, {super.key, this.textAlign, this.color});
  final String text;
  final TextAlign? textAlign;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: color ?? const Color(0xff6c7884),
      ),
    );
  }
}
