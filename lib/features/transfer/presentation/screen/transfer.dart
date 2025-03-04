import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/transfer/transfer.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:provider/provider.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransferVm>();
    return AppScaffoldWidget(
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YBox(Insets.dim_22.h),
          Text(
            'Transfer',
            style: context.textTheme.bodySmall!.copyWith(
              fontSize: Insets.dim_18.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ),
          YBox(Insets.dim_18.h),
          Text(
            'Select Type',
            style: context.textTheme.bodySmall!.copyWith(
              fontSize: Insets.dim_16.sp,
              color: AppColors.black.withOpacity(0.7),
              fontWeight: FontWeight.w400,
            ),
          ),
          YBox(Insets.dim_28.h),
          ...List.generate(
            provider.items(context).length,
            (index) {
              final item = provider.items(context)[index];
              return GestureDetector(
                onTap: item.onTap ?? () {},
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Insets.dim_16.w,
                        vertical: Insets.dim_16.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.black.withOpacity(0.2),
                        ),
                        borderRadius: Corners.mdBorder,
                      ),
                      child: Row(
                        children: [
                          if (item.img != null)
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: LocalImage(
                                item.img!,
                                height: Insets.dim_60.h,
                                width: Insets.dim_60.w,
                              ),
                            ),
                          XBox(Insets.dim_14.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: context.textTheme.bodySmall!.copyWith(
                                    fontSize: Insets.dim_14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black.withOpacity(0.8),
                                  ),
                                ),
                                YBox(Insets.dim_8.h),
                                Text(
                                  item.subtitle ?? '',
                                  style: context.textTheme.bodySmall!.copyWith(
                                    fontSize: Insets.dim_14.sp,
                                    color: AppColors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    YBox(Insets.dim_12.h),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
