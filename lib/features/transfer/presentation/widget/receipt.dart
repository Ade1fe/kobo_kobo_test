import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/core/core.dart';
import 'package:kobo_kobo/functional_util/assets.dart';
import 'package:kobo_kobo/functional_util/date/date_util.dart';
import 'package:kobo_kobo/functional_util/extensions/extensions.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final title = [
      ItemClass(title: 'Sender', subtitle: 'Adisa Taiwo'),
      ItemClass(title: 'Beneficiary', subtitle: 'Adams Joshua'),
      ItemClass(title: 'Beneficiary Account Number ', subtitle: '0034507169'),
      ItemClass(title: 'Remark', subtitle: 'Refund'),
      ItemClass(
          title: 'Transaction Reference', subtitle: '012345678909876543210'),
    ];
    return AppScaffoldWidget(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LocalImage(
                    appPngLogo,
                    height: Insets.dim_100.h,
                  ),
                  FittedBox(
                    child: Text(
                      'Your Sure Partner to \nFinancial Freedom',
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.appPrimaryColor,
                        fontSize: Insets.dim_10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              XBox(Insets.dim_24.w),
              Column(
                children: [
                  Text(
                    'Transaction Receipt',
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.black,
                      fontSize: Insets.dim_18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  YBox(Insets.dim_26.h),
                  Text(
                    context.money().formatWithCurrencySymbol(65255414),
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.black.withOpacity(0.8),
                      fontSize: Insets.dim_20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  YBox(Insets.dim_10.h),
                  Text(
                    'Success',
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.green,
                      fontSize: Insets.dim_20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  YBox(Insets.dim_10.h),
                  Text(
                    DateFormatUtil.formatDate(
                      dateTimeFormat,
                      DateTime.now().toIso8601String(),
                    ),
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.black.withOpacity(0.5),
                      fontSize: Insets.dim_12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          YBox(Insets.dim_20.h),
          Expanded(
            child: ListView.builder(
              itemCount: title.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title[index].title,
                      textAlign: TextAlign.start,
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                        fontSize: Insets.dim_12.sp,
                      ),
                    ),
                    YBox(Insets.dim_8.h),
                    Text(
                      title[index].subtitle ?? '',
                      textAlign: TextAlign.start,
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w600,
                        fontSize: Insets.dim_14.sp,
                      ),
                    ),
                    YBox(Insets.dim_20.h),
                  ],
                );
              },
            ),
          ),
          Text(
            'Support',
            style: context.textTheme.bodySmall!.copyWith(
              color: AppColors.black.withOpacity(0.5),
              fontWeight: FontWeight.w600,
              fontSize: Insets.dim_14.sp,
            ),
          ),
          YBox(Insets.dim_6.h),
          Text(
            'help@kobokobo.com',
            style: context.textTheme.bodySmall!.copyWith(
              color: AppColors.appPrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: Insets.dim_14.sp,
            ),
          ),
          YBox(Insets.dim_60.h),
          AppButton(textTitle: 'Share', action: () {}),
          YBox(Insets.dim_60.h),
        ],
      ),
    );
  }
}
