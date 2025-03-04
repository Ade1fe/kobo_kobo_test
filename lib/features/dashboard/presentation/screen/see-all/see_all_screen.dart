import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final money = context.money();
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Insets.dim_16.h,
        horizontal: Insets.dim_8.w,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.black.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Insets.dim_16.sp),
          topRight: Radius.circular(Insets.dim_16.sp),
        ),
      ),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ActivityItem(
            name: ['John Maxwell', 'Peter Jowe', 'Mira Jane'][index % 3],
            type: index.isEven ? 'Outgoing transfer' : 'Incoming transfer',
            amount: [2307, 52334, 8643][index % 3],
            isOutgoing: index.isEven,
            money: money,
          );
        },
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final String name;
  final String type;
  final int amount;
  final bool isOutgoing;
  final dynamic money;

  const ActivityItem({
    super.key,
    required this.name,
    required this.type,
    required this.amount,
    required this.isOutgoing,
    required this.money,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Insets.dim_8.w,
      ),
      padding: EdgeInsets.only(
        top: Insets.dim_16.h,
        bottom: Insets.dim_16.h,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: AppColors.black.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          LocalSvgImage(
            isOutgoing ? outflowArrowSvg : inflowArrowSvg,
          ),
          XBox(Insets.dim_20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.black,
                    fontSize: Insets.dim_14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                YBox(Insets.dim_4.h),
                Text(
                  type,
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withValues(alpha: 0.6),
                    fontSize: Insets.dim_10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isOutgoing ? '-' : ''} ${money.formatWithCurrencySymbol(
                  amount,
                  currencyShortName: 'NGN',
                )}',
                style: context.textTheme.bodySmall!.copyWith(
                  color: isOutgoing
                      ? AppColors.outgoingColor
                      : AppColors.incomingColor,
                  fontSize: Insets.dim_14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              YBox(Insets.dim_4.h),
              Text(
                DateFormatUtil.formatDate(
                  dateFormat,
                  DateTime.now().toIso8601String(),
                ),
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.black.withValues(alpha: 0.6),
                  fontSize: Insets.dim_10.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
