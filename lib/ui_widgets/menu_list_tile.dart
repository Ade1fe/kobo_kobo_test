import 'package:flutter/material.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class MenuListTile extends StatelessWidget {
  const MenuListTile({
    super.key,
    required this.title,
    this.showWidget = true,
    this.assetName,
    this.radius = 16,
    this.iconData,
    this.trailingWidget,
    this.onMenuTapped,
    this.showCircularBackground = false,
    this.circularBackgroundColor = AppColors.makePaymentBg,
    this.horizontalTitleGap,
    this.iconColor = AppColors.appPrimaryColor,
    this.subtitle,
  })  : assert(
          assetName == null || iconData == null,
          "Only provide either 'assetName' or 'iconData'",
        );

  final String title;
  final String? assetName;
  final double radius;
  final IconData? iconData;
  final bool showCircularBackground;
  final Color circularBackgroundColor;
  final Color iconColor;
  final double? horizontalTitleGap;
  final Widget? trailingWidget;
  final Function()? onMenuTapped;
  final bool showWidget;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return showWidget
        ? GestureDetector(
            onTap: () => {
              if (onMenuTapped != null) {onMenuTapped!()},
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 12, right: 12),
              child: Container(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: assetName != null || iconData != null
                      ? CircleAvatar(
                          radius: radius,
                          backgroundColor: showCircularBackground
                              ? circularBackgroundColor
                              : Colors.transparent,
                          child: iconData != null
                              ? Icon(
                                  iconData,
                                  color: iconColor,
                                )
                              : assetName != null && assetName!.endsWith('.svg')
                                  ? Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: const BoxDecoration(
                                          borderRadius: Corners.rsBorder,
                                        ),
                                        child: LocalSvgImage(assetName!),
                                      ),
                                    )
                                  : LocalImage(assetName!),
                        )
                      : null,
                  horizontalTitleGap: horizontalTitleGap,
                  trailing: trailingWidget ??
                      const Icon(
                        Icons.chevron_right,
                      ),
                  title: Text(
                    title,
                    style: context.textTheme.titleSmall!.copyWith(
                      color: AppColors.black.withOpacity(0.88),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  subtitle: subtitle != null
                      ? Text(
                          subtitle!,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontSize: 12,
                                    color: const Color(0xff6C7884),
                                    fontWeight: FontWeight.w500,
                                  ),
                        )
                      : null,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
