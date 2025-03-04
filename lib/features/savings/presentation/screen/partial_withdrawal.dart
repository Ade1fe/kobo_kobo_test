import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/features/savings/savings.dart';
import 'package:kobo_kobo/features/transfer/transfer.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class PartialWithdrawalScreen extends StatefulWidget {
  const PartialWithdrawalScreen({super.key, required this.args});
  final ReviewSavingsArgs args;

  @override
  State<PartialWithdrawalScreen> createState() =>
      _PartialWithdrawalScreenState();
}

class _PartialWithdrawalScreenState extends State<PartialWithdrawalScreen> {
  late TransferVm vm;
  bool showRollOver = false;
  bool lockSaving = false;
  bool isPartial = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      setState(() {
        vm.showSavingsSheet = false;
        isPartial =
            widget.args.savingsDto.withdrawalType.toLowerCase() == 'top-up'
                ? false
                : true;
      });
      Log().debug('vm.showSavingsSheet is ${vm.showSavingsSheet}');
    });
  }

  @override
  Widget build(BuildContext context) {
    vm = context.watch<TransferVm>();
    if (mounted && vm.showSavingsSheet) {
      Future.delayed(1.seconds).then((_) {
        AppNavigator.of(context).push(
          AppRoutes.savingsPinToTransStatus,
          args: GenericDialogueArgs(
            title: 'Success',
            icon: LocalImage(
              successPng,
              height: Insets.dim_100.h,
              width: Insets.dim_100.w,
            ),
            btn1Title: '',
            btn2Title: 'Done',
            btn1Color: AppColors.appPrimaryColor,
            btn2Color: AppColors.appPrimaryColor,
            onBtn1PressedRoute: AppRoutes.home,
            onBtn2PressedRoute: AppRoutes.home,
          ),
        );
      });
    }

    return AppScaffoldWidget(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YBox(Insets.dim_22.h),
            Text(
              widget.args.savingsDto.withdrawalType,
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: Insets.dim_18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            YBox(Insets.dim_18.h),
            Text(
              'Choose Savings Account',
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: Insets.dim_16.sp,
                color: AppColors.black.withOpacity(0.7),
              ),
            ),
            YBox(Insets.dim_10.h),
            const InAppSourceAccount(),
            YBox(Insets.dim_40.h),
            Text(
              'Choose account to credit',
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: Insets.dim_16.sp,
                color: AppColors.black.withOpacity(0.7),
              ),
            ),
            YBox(Insets.dim_10.h),
            const InAppSourceAccount(),
            YBox(Insets.dim_40.h),
            if (widget.args.savingsDto.withdrawalType.toLowerCase() ==
                'top-up') ...[
              AppTextFormField(
                labelText: 'Top-Up Amount',
                hintText: 'Enter amount to top-up',
                validator: (input) => Validators.validateAmount()(input),
                inputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              YBox(Insets.dim_28.h),
              ClickableFormField(
                labelText: 'Tenure',
                hintText: 'Select number of days',
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.black,
                  size: Insets.dim_24.sp,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: AppColors.white,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Insets.dim_20.w,
                        ),
                        height: context.getHeight(0.8.h),
                        child: Column(
                          children: [
                            YBox(Insets.dim_20.h),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: vm.tenureDuration.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      height: Insets.dim_44.h,
                                      child: Text(
                                        vm.tenureDuration[index],
                                        style: context.textTheme.bodySmall!
                                            .copyWith(
                                          color:
                                              AppColors.black.withOpacity(0.88),
                                          fontSize: Insets.dim_16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              YBox(Insets.dim_20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Automatic roll-over',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: AppColors.black.withOpacity(.8),
                          fontSize: Insets.dim_16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Reinvest my funds at maturity',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: AppColors.black.withOpacity(.5),
                          fontSize: Insets.dim_14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Switch.adaptive(
                    value: showRollOver,
                    onChanged: (value) => setState(() => showRollOver = value),
                    activeColor: AppColors.appPrimaryButton,
                  ),
                ],
              ),
              YBox(Insets.dim_20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lock Savings',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: AppColors.black.withOpacity(.8),
                          fontSize: Insets.dim_16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Lock savings for a higher interest rate',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: AppColors.black.withOpacity(.8),
                          fontSize: Insets.dim_16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Switch.adaptive(
                    value: lockSaving,
                    onChanged: (value) => setState(() => lockSaving = value),
                    activeColor: AppColors.appPrimaryButton,
                  ),
                ],
              ),
              YBox(context.getHeight(0.15.h)),
              AppButton(
                textTitle: 'Proceed',
                action: () => showSuccessSheet(isPartial),
              ),
              YBox(context.getHeight(0.07.h)),
            ] else ...[
              AppTextFormField(
                labelText: 'Amount To Withdraw',
                hintText: 'Enter amount to withdraw',
                validator: (input) => Validators.validateAmount()(input),
                inputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              YBox(context.getHeight(0.15.h)),
              AppButton(
                textTitle: 'Proceed',
                action: () => showSuccessSheet(isPartial),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void showSuccessSheet(bool isPartial) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      builder: (context) {
        final money = context.money();
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: Insets.dim_20.w,
          ),
          height: context.getHeight(0.8.h),
          child: ListView(
            children: [
              YBox(Insets.dim_20.h),
              Row(
                children: [
                  XBox(Insets.dim_12.w),
                  const Spacer(),
                  Text(
                    isPartial
                        ? widget.args.savingsDto.withdrawalType
                        : '${widget.args.savingsDto.withdrawalType} Summary',
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                      fontSize: Insets.dim_18.sp,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(left: Insets.dim_16.w),
                    child: Icon(
                      PhosphorIcons.x(PhosphorIconsStyle.bold),
                      color: AppColors.borderErrorColor,
                      size: Insets.dim_26.sp,
                    ),
                  ).onTap(() => AppNavigator.of(context).popDialog()),
                  XBox(Insets.dim_12.w),
                ],
              ),
              YBox(Insets.dim_20.h),
              previewWidget(context, 'Savings Name', 'Papa’s 70th Birthday'),
              previewWidget(context, isPartial ? 'Amount' : 'Top-Up amount',
                  money.formatWithCurrencySymbol(4000)),
              if (isPartial) ...[
                previewWidget(
                    context, 'Account to Credit', 'Individual Account'),
                previewWidget(context, 'Withdrawal Amount',
                    money.formatWithCurrencySymbol(4000)),
                previewWidget(context, 'Interest Amount',
                    money.formatWithCurrencySymbol(400)),
              ] else ...[
                previewWidget(context, 'Tenure', widget.args.savingsDto.tenure),
                previewWidget(context, 'Interest Rate',
                    '${widget.args.savingsDto.interestRate}%'),
                previewWidget(context, 'Interest Amount',
                    money.formatWithCurrencySymbol(400)),
                previewWidget(context, 'Amount at Maturity',
                    money.formatWithCurrencySymbol(5000)),
                previewWidget(context, 'Maturity Date',
                    widget.args.savingsDto.maturityDate),
                previewWidget(context, 'Automatic Rollover',
                    widget.args.savingsDto.rollover),
                previewWidget(
                    context, 'Lock Savings', widget.args.savingsDto.lock),
              ],
              YBox(Insets.dim_20.h),
              AppButton(
                textTitle: 'Confirm',
                backgroundColor: AppColors.appPrimaryButton,
                action: () {
                  AppNavigator.of(context).popDialog();
                  AppNavigator.of(context).push(
                    AppRoutes.savingsWithdrawalToPin,
                    args: SavingsPinArgs(
                      route: AppRoutes.savingDetailsWithdraw,
                      extra: ReviewSavingsArgs(
                        savingsDto: SavingsDto.empty(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget previewWidget(BuildContext context, String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Insets.dim_16.w,
        vertical: Insets.dim_16.h,
      ),
      child: Row(
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: context.textTheme.bodySmall!.copyWith(
              color: AppColors.black.withOpacity(0.7),
              fontWeight: FontWeight.w400,
              fontSize: Insets.dim_14.sp,
            ),
          ),
          const Spacer(),
          Text(
            subtitle,
            textAlign: TextAlign.start,
            style: context.textTheme.bodySmall!.copyWith(
              color: subtitle.toLowerCase() == 'active'
                  ? AppColors.green
                  : AppColors.black.withOpacity(0.8),
              fontWeight: FontWeight.w500,
              fontSize: Insets.dim_18.sp,
            ),
          ),
        ],
      ),
    );
  }
}
