import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/features/savings/savings.dart';
import 'package:kobo_kobo/functional_util/extensions/extensions.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class ReviewSavingsArgs {
  final SavingsDto savingsDto;

  ReviewSavingsArgs({required this.savingsDto});
}

class ReviewSavings extends StatelessWidget {
  const ReviewSavings({super.key, required this.args});
  final ReviewSavingsArgs args;

  @override
  Widget build(BuildContext context) {
    final money = context.money();
    return AppScaffoldWidget(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              args.savingsDto.title,
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.black.withOpacity(.8),
                fontSize: Insets.dim_16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            YBox(Insets.dim_50.h),
            Text(
              'Overview',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.black.withOpacity(.8),
                fontSize: Insets.dim_16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            YBox(Insets.dim_54.h),
            Container(
              width: context.getWidth(),
              padding: EdgeInsets.symmetric(
                vertical: Insets.dim_8.h,
                horizontal: Insets.dim_4.w,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.appPrimaryButton.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.appPrimaryButton.withOpacity(0.09),
                    blurRadius: 4,
                    offset: const Offset(0, 5),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  rowDataWidget(
                      context,
                      'Amount Invested',
                      money.formatWithCurrencySymbol(
                          args.savingsDto.amountInvested)),
                  YBox(Insets.dim_24.h),
                  rowDataWidget(context, 'Tenure', args.savingsDto.tenure),
                  YBox(Insets.dim_24.h),
                  rowDataWidget(context, 'Interest Rate',
                      '${args.savingsDto.interestRate}%'),
                  YBox(Insets.dim_24.h),
                  rowDataWidget(
                      context,
                      'Interest Earned',
                      money.formatWithCurrencySymbol(
                          args.savingsDto.interestEarned)),
                  YBox(Insets.dim_24.h),
                  rowDataWidget(context, 'Investment Date',
                      args.savingsDto.investmentDate),
                  YBox(Insets.dim_24.h),
                  rowDataWidget(
                      context, 'Investment Status', args.savingsDto.status),
                  YBox(Insets.dim_24.h),
                  rowDataWidget(
                      context, 'Maturity Date', args.savingsDto.maturityDate),
                  YBox(Insets.dim_24.h),
                  rowDataWidget(
                      context, 'Automatic Rollover', args.savingsDto.rollover),
                  YBox(Insets.dim_24.h),
                  rowDataWidget(context, 'Lock Savings', args.savingsDto.lock),
                  YBox(Insets.dim_24.h),
                ],
              ),
            ),
            YBox(Insets.dim_100.h),
            rowDataWidget(context, 'Total Amount on Maturity',
                money.formatWithCurrencySymbol(args.savingsDto.totalAmount)),
            if (args.savingsDto.status.toLowerCase() == 'active') ...[
              YBox(Insets.dim_50.h),
              AppButton(
                textTitle: 'Top-Up',
                action: () {
                  SavingsDto param = args.savingsDto;
                  param = param.copyWith(
                    withdrawalType: 'Top-Up',
                  );
                  AppNavigator.of(context).push(
                    AppRoutes.savingDetailsWithdraw,
                    args: ReviewSavingsArgs(
                      savingsDto: param,
                    ),
                  );
                },
              ),
              YBox(Insets.dim_14.h),
              AppOutlineButton(
                textTitle: 'Withdraw',
                action: () {
                  final texts = [
                    'Full Withdrawal',
                    'Partial Withdrawal',
                  ];
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: AppColors.white,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Insets.dim_20.w,
                        ),
                        height: context.getHeight(0.2.h),
                        child: Column(
                          children: [
                            YBox(Insets.dim_40.h),
                            Expanded(
                              child: ListView.builder(
                                itemCount: texts.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    height: Insets.dim_44.h,
                                    child: Text(
                                      texts[index],
                                      style:
                                          context.textTheme.bodySmall!.copyWith(
                                        color:
                                            AppColors.black.withOpacity(0.88),
                                        fontSize: Insets.dim_16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ).onTap(
                                    () {
                                      SavingsDto param = args.savingsDto;
                                      param = param.copyWith(
                                        withdrawalType: texts[index],
                                      );
                                      AppNavigator.of(context).push(
                                        AppRoutes.savingDetailsWithdraw,
                                        args: ReviewSavingsArgs(
                                          savingsDto: param,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              YBox(Insets.dim_50.h),
            ],
          ],
        ),
      ),
    );
  }

  Widget rowDataWidget(BuildContext context, String title, String desc) {
    return Row(
      children: [
        Text(
          title,
          style: context.textTheme.bodySmall!.copyWith(
            color: AppColors.black.withOpacity(.6),
            fontSize: Insets.dim_18.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Spacer(),
        Text(
          desc,
          style: context.textTheme.bodySmall!.copyWith(
            color: AppColors.black.withOpacity(.8),
            fontSize: Insets.dim_18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
