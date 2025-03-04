import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    super.key,
    required this.sheetBody,
    this.screenPercentage,
    this.onDismissed,
    this.normalHeight,
    this.showCloseButton = true,
  })  : assert(
          screenPercentage != null || normalHeight != null,
          'both screenPercentage and normalHeight must not be null at theSame time',
        );

  final Widget sheetBody;
  //either screenPercentage or
  //Normal height must be given
  //where both is given,
  //would use normal Height
  final double? screenPercentage;
  final double? normalHeight;
  final bool Function()? onDismissed;
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    final bottomSheetHeight =
        normalHeight ?? MediaQuery.of(context).size.height * screenPercentage!;
    return PopScope(
      canPop: onDismissed?.call() ?? true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: bottomSheetHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(24),
                          topLeft: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Align(
                                child: Container(
                                  width: 75,
                                  height: 8,
                                  margin: const EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6C7884)
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Visibility(
                                      visible: showCloseButton,
                                      child: IconButton(
                                        onPressed: () {
                                          //pls don't forget to return true if you want the bottom sheet to
                                          //be popped from here.
                                          //this feature should allow control when we want the
                                          //bottom sheet to be popped.

                                          final shouldPop =
                                              onDismissed?.call() ?? true;
                                          if (shouldPop == true) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(child: sheetBody),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
