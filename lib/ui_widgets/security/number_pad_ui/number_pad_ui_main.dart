import 'package:flutter/material.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/security/number_pad_ui/number_pad_ui.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:pinput/pinput.dart';

class NumberPadViewUi extends StatefulWidget {
  const NumberPadViewUi({
    super.key,
    required this.title,
    required this.subtitle,
    this.shouldConfirmPin = false,
    this.initialPinValue,
    this.onCompleted,
  });

  final String title;
  final String subtitle;
  final bool shouldConfirmPin;
  final String? initialPinValue;
  final dynamic Function(String pin)? onCompleted;

  @override
  State<NumberPadViewUi> createState() => _NumberPadViewUiState();
}

class _NumberPadViewUiState extends State<NumberPadViewUi> {
  final pinController = TextEditingController();

  String _defaultValue = '';

  bool _isLoading = false;

  void _pinListener() {
    if (mounted) {
      setState(() => _defaultValue = pinController.text);
    }
  }

  void _runCustomFunction(String pin) {
    updateLoading(value: true);

    // ignore: avoid_dynamic_calls
    widget.onCompleted!(pin).then(
      (_) {
        updateLoading(value: false);
      },
      onError: (err) {
        // Can show error message
        updateLoading(value: false);
      },
    );
  }

  void updateLoading({required bool value}) {
    if (mounted) {
      setState(() => _isLoading = value);
    }
  }

  final defaultPinTheme = PinTheme(
    width: 48,
    height: 48,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Color(0xff7165E3),
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color(0xffE8EBEE),
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  @override
  void initState() {
    super.initState();

    pinController.addListener(_pinListener);
  }

  @override
  void dispose() {
    pinController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(
          double.infinity,
          kToolbarHeight,
        ),
        child: CustomAppBar(
          title: widget.title,
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  widget.subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff6C7884),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 46,
                ),
                if (_isLoading)
                  const CircularProgressIndicator.adaptive()
                else
                  Pinput(
                    controller: pinController,
                    length: 6,
                    readOnly: true,
                    autofocus: true,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff7165E3),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onCompleted: (pin) async {
                      // Confirm is initial and confirm matches
                      if (widget.shouldConfirmPin &&
                          widget.initialPinValue != null) {
                        if (pin != widget.initialPinValue) {
                          showErrorNotification("PIN don't match");

                          return;
                        }

                        if (widget.onCompleted != null) {
                          _runCustomFunction(pin);

                          return;
                        }
                      }

                      // Run custom function.
                      // Would return if conditions are met
                      if (widget.onCompleted != null) {
                        _runCustomFunction(pin);
                        return;
                      }
                      AppNavigator.of(context).popDialog(pin);
                    },
                  ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: NumberPadUi(
              isForAuth: true,
              maxLength: 6,
              defaultValue: _defaultValue,
              onChanged: pinController.setText,
              onDelete: pinController.delete,
            ),
          ),
        ],
      ),
    );
  }
}
