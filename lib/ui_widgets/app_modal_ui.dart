import 'package:kobo_kobo/functional_util/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class AppModalUi extends StatelessWidget {
  const AppModalUi({
    super.key,
    required this.child,
    this.contentPadding = 24.0,
    this.horizontalPadding = 28.0,
    this.bottomPadding = 20,
    this.isDismissible = true,
  });

  final Widget child;
  final double contentPadding;
  final double horizontalPadding;
  final double bottomPadding;
  final bool isDismissible;

  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(24);
    final kBottomPadding = MediaQuery.of(context).padding.bottom;
    return SafeArea(
      bottom: false,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xffD7D4F7),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 19,
                  top: 20,
                  bottom: 9,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.close,
                      color: AppColors.black,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Close',
                      style: context.textTheme.displayMedium?.copyWith(
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: borderRadius,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: contentPadding),
                  Flexible(child: child),
                  SizedBox(height: bottomPadding + kBottomPadding),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
