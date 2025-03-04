import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kobo_kobo/ui_widgets/security/number_pad_ui/number_button_widget.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class NumberPadUi extends StatefulWidget {
  const NumberPadUi({
    super.key,
    required this.onChanged,
    required this.onDelete,
    required this.maxLength,
    required this.defaultValue,
    this.isForAuth = false,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });
  final void Function(String) onChanged;
  final VoidCallback onDelete;
  final int maxLength;
  final String defaultValue;
  final MainAxisAlignment mainAxisAlignment;
  final bool isForAuth;

  @override
  State<NumberPadUi> createState() => _NumberPadUiState();
}

class _NumberPadUiState extends State<NumberPadUi> {
  @override
  void dispose() {
    super.dispose();
  }

  bool _isLongPress = false;

  void _appendValue(String val) {
    if (widget.defaultValue.length == widget.maxLength) {
      //ensure that defaultValue's length = maxlength
      return;
    }

    //Implementation for pin
    //Just go ahead and append it as far
    //as it's not greater than maxlength
    final newVal = '${widget.defaultValue}$val'; //widget.defaultValue += text
    widget.onChanged(newVal);
    return;
  }

  void _removeValue() {
    widget.onDelete();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberPadBtnWidget(
              text: '1',
              onPressed: () {
                _appendValue('1');
              },
            ),
            const SizedBox(width: 28),
            NumberPadBtnWidget(
              text: '2',
              onPressed: () {
                _appendValue('2');
              },
            ),
            const SizedBox(width: 28),
            NumberPadBtnWidget(
              text: '3',
              onPressed: () {
                _appendValue('3');
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberPadBtnWidget(
              text: '4',
              onPressed: () {
                _appendValue('4');
              },
            ),
            const SizedBox(width: 28),
            NumberPadBtnWidget(
              text: '5',
              onPressed: () {
                _appendValue('5');
              },
            ),
            const SizedBox(width: 28),
            NumberPadBtnWidget(
              text: '6',
              onPressed: () {
                _appendValue('6');
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberPadBtnWidget(
              text: '7',
              onPressed: () {
                _appendValue('7');
              },
            ),
            const SizedBox(width: 28),
            NumberPadBtnWidget(
              text: '8',
              onPressed: () {
                _appendValue('8');
              },
            ),
            const SizedBox(width: 28),
            NumberPadBtnWidget(
              text: '9',
              onPressed: () {
                _appendValue('9');
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 75,
              height: 75,
            ),
            const SizedBox(width: 28),
            NumberPadBtnWidget(
              text: '0',
              onPressed: () {
                _appendValue('0');
              },
            ),
            const SizedBox(width: 28),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (widget.defaultValue.isNotEmpty) {
                  HapticFeedback.lightImpact();
                  _removeValue();
                }
              },
              onLongPressStart: (_) async {
                _isLongPress = true;
                do {
                  _removeValue();
                  await Future<void>.delayed(
                    const Duration(milliseconds: 300),
                  );
                } while (_isLongPress);
              },
              onLongPressEnd: (_) => {
                setState(
                  () => _isLongPress = false,
                ),
              },
              child: const SizedBox.square(
                dimension: 72,
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
