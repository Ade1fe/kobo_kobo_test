import 'package:flutter/material.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({
    super.key,
    required this.title,
    this.isRequiredField = false,
  });
  final String title;
  final bool isRequiredField;

  @override
  Widget build(BuildContext context) {
    return isRequiredField
        ? RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: context.textTheme.bodySmall!.apply(
                    color: AppColors.black,
                  ),
                ),
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(4, 4),
                    child: Text(
                      '*',
                      //superscript is usually smaller in size
                      style: context.textTheme.bodyLarge!.apply(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Text(
            title,
            style: context.textTheme.bodySmall!.apply(
              color: AppColors.black,
            ),
            textAlign: TextAlign.start,
          );
  }
}
