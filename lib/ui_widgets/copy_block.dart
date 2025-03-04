import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class CopyBlock extends StatelessWidget {
  const CopyBlock({
    super.key,
    required this.context,
    required this.title,
    required this.subTitle,
    this.isActive = true,
  });

  final BuildContext context;
  final String title;
  final String subTitle;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Insets.dim_8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: Insets.dim_16),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: const Color(0xff6c7884),
                fontWeightDelta: 2,
              ),
          textAlign: TextAlign.start,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: Insets.dim_12),
          child: Text(
            isActive == true ? subTitle : 'XXXXXXXXXXXXXXXXXXXXXXX',
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: const Color(0xff6c7884),
                ),
            textAlign: TextAlign.start,
          ),
        ),
        trailing: GestureDetector(
          onTap: isActive == false
              ? null
              : () {
                  Clipboard.setData(ClipboardData(text: subTitle)).then((_) {
                    showInfoNotification('$title copied to clipboard');
                  });
                },
          child: Container(
            decoration: BoxDecoration(
              color: isActive == true
                  ? AppColors.makePaymentBg
                  : AppColors.makePaymentBg.withOpacity(.3),
              borderRadius: BorderRadius.circular(4),
            ),
            width: Insets.dim_50,
            height: Insets.dim_32,
            alignment: Alignment.center,
            child: Text(
              'Copy',
              style: Theme.of(context).textTheme.bodySmall!.apply(
                    color: isActive == true
                        ? AppColors.appPrimaryColor
                        : AppColors.appPrimaryColor.withOpacity(.3),
                    fontWeightDelta: 2,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
