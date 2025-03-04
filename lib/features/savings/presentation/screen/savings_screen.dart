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

class SavingsScreen extends StatefulWidget {
  const SavingsScreen({super.key});

  @override
  State<SavingsScreen> createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen>
    with TickerProviderStateMixin {
  bool showRollOver = false;
  bool lockSaving = false;
  late TabController _tabController;
  late TabController _tab2Controller;
  TextEditingController accTEC = TextEditingController();
  TextEditingController bankTEC = TextEditingController();
  SavingsDto param = SavingsDto.empty();

  int activeTabIndex = 0;
  int active2TabIndex = 0;
  int? selectedIndex;

  late TransferVm vm;

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(vsync: this, length: 2, initialIndex: activeTabIndex);
    _tab2Controller =
        TabController(vsync: this, length: 2, initialIndex: active2TabIndex);

    _tabController.addListener(() {
      setState(() {
        activeTabIndex = _tabController.index;
      });
    });
    _tab2Controller.addListener(() {
      setState(() {
        active2TabIndex = _tab2Controller.index;
      });
    });

    param = param.copyWith(
      amountInvested: 5000,
      tenure: '90 Days',
      interestRate: 10,
      interestEarned: 0.5,
      investmentDate: DateTime.now().getDate(),
      maturityDate: DateTime.now().add(90.days).getDate(),
      lock: 'Inactive',
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tab2Controller.dispose();
    super.dispose();
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
              'Savings',
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: Insets.dim_18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            YBox(Insets.dim_18.h),
            Text(
              'Source Account',
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: Insets.dim_16.sp,
                color: AppColors.black.withOpacity(0.7),
              ),
            ),

            YBox(Insets.dim_10.h),
            const InAppSourceAccount(),
            YBox(Insets.dim_20.h),
            Text(
              'Product Name',
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.black.withOpacity(0.88),
                fontSize: Insets.dim_16.sp,
              ),
            ),
            YBox(Insets.dim_10.h),
            TabBar(
              controller: _tabController,
              tabs: [
                _tabWidget('Fixed Savings', 0),
                _tabWidget('Target Savings', 1),
              ],
              padding: EdgeInsets.zero,
              indicatorColor: AppColors.white,
              indicatorPadding: EdgeInsets.only(right: Insets.dim_40.w),
              unselectedLabelColor: AppColors.borderColor,
              dividerColor: AppColors.white,
              overlayColor: const WidgetStatePropertyAll(
                AppColors.white,
              ),
              labelPadding: EdgeInsets.only(bottom: Insets.dim_6.h),
              unselectedLabelStyle: context.textTheme.bodyMedium!
                  .copyWith(color: AppColors.borderColor),
            ),
            YBox(Insets.dim_12.h),
            TabBar(
              controller: _tab2Controller,
              tabs: [
                _tab2Widget('Add New', 0),
                _tab2Widget('View All', 1),
              ],
              padding: EdgeInsets.zero,
              indicatorColor: AppColors.appPrimaryButton,
              unselectedLabelColor: AppColors.borderColor,
              dividerColor: AppColors.white,
              overlayColor: const WidgetStatePropertyAll(AppColors.white),
            ),
            if (active2TabIndex == 0 && activeTabIndex == 0) ...[
              YBox(Insets.dim_12.h),
              AppTextFormField(
                labelText: 'Savings Name',
                hintText: 'Enter savings name ',
                inputType: TextInputType.text,
                validator: (value) => Validators.validateString()(value),
              ),
              YBox(Insets.dim_12.h),
              AppTextFormField(
                labelText: 'Amount',
                hintText: '0000',
                inputType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) => Validators.validateString()(value),
              ),
              YBox(Insets.dim_12.h),
              ClickableFormField(
                labelText: 'Tenure',
                hintText: 'Select number of days',
                controller: bankTEC,
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
              YBox(Insets.dim_12.h),
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
              if (showRollOver) ...[
                Container(
                  width: context.getWidth(),
                  padding: EdgeInsets.symmetric(
                    horizontal: Insets.dim_16.w,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.appPrimaryButton,
                    ),
                    borderRadius: Corners.rsBorder,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Principal + Interest',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: AppColors.appPrimaryButton,
                        ),
                      ),
                      const Spacer(),
                      const Checkbox(value: false, onChanged: null),
                    ],
                  ),
                ),
                YBox(Insets.dim_14.h),
                Container(
                  width: context.getWidth(),
                  padding: EdgeInsets.symmetric(
                    horizontal: Insets.dim_16.w,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.appPrimaryButton,
                    ),
                    borderRadius: Corners.rsBorder,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Principal Only',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: AppColors.appPrimaryButton,
                        ),
                      ),
                      const Spacer(),
                      const Checkbox(value: false, onChanged: null),
                    ],
                  ),
                ),
                YBox(Insets.dim_12.h),
              ],
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
                          color: AppColors.black.withOpacity(.5),
                          fontSize: Insets.dim_14.sp,
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
              YBox(Insets.dim_40.h),
              AppButton(
                textTitle: 'Continue',
                action: () {
                  if (lockSaving) {
                    showLockSheet();
                    return;
                  }
                  showSuccessSheet();
                },
              ),
              YBox(Insets.dim_50.h),
            ] else if (active2TabIndex == 0 && activeTabIndex == 1) ...[
              YBox(Insets.dim_12.h),
              AppTextFormField(
                labelText: 'Target Savings Name',
                hintText: 'What are you saving for?',
                inputType: TextInputType.text,
                validator: (value) => Validators.validateString()(value),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(15),
                ],
              ),
              Text(
                'Max. 15 Characters',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.appPrimaryButton,
                  fontSize: Insets.dim_14.sp,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
              YBox(Insets.dim_14.h),
              AppTextFormField(
                labelText: 'Target Amount',
                hintText: 'Enter target amount ',
                inputType: TextInputType.number,
                validator: (value) => Validators.validateString()(value),
              ),
              YBox(Insets.dim_12.h),
              AppTextFormField(
                labelText: 'Initial Amount (Optional)',
                hintText: 'Enter initial amount',
                inputType: TextInputType.number,
                validator: (value) => Validators.validateString()(value),
              ),
              YBox(Insets.dim_12.h),
              ClickableFormField(
                labelText: 'Start Date',
                hintText: 'DD/MM/YYYY',
                suffixIcon: Icon(
                  PhosphorIcons.calendar(),
                ),
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  await DatePickerUtil.adaptive(
                    context,
                    isDateOfBirth: false,
                    onDateTimeChanged: (date) {
                      setState(() {});
                    },
                  );
                },
              ),
              YBox(Insets.dim_12.h),
              ClickableFormField(
                labelText: 'End Date',
                hintText: 'DD/MM/YYYY',
                suffixIcon: Icon(
                  PhosphorIcons.calendar(),
                ),
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  await DatePickerUtil.adaptive(
                    context,
                    isDateOfBirth: false,
                    onDateTimeChanged: (date) {
                      setState(() {});
                    },
                  );
                },
              ),
              YBox(Insets.dim_12.h),
              ClickableFormField(
                labelText: 'Saving Frequency',
                hintText: 'Daily',
                suffixIcon: const Icon(
                  Icons.arrow_drop_down,
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
                        height: context.getHeight(0.25.h),
                        child: Column(
                          children: [
                            YBox(Insets.dim_50.h),
                            Expanded(
                              child: ListView.builder(
                                itemCount: vm.savingFrequency.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    height: Insets.dim_44.h,
                                    child: Text(
                                      vm.savingFrequency[index],
                                      style:
                                          context.textTheme.bodySmall!.copyWith(
                                        color:
                                            AppColors.black.withOpacity(0.88),
                                        fontSize: Insets.dim_16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
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
              YBox(Insets.dim_12.h),
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
              YBox(Insets.dim_40.h),
              AppButton(
                textTitle: 'Continue',
                action: () {
                  if (lockSaving) {
                    showLockSheet();
                    return;
                  }
                  showSuccessSheet();
                },
              ),
              YBox(Insets.dim_50.h),
            ],

            //View all tab
            if (active2TabIndex == 1) ...[
              YBox(Insets.dim_20.h),
              const DecoratedContainer(
                title: 'Total Fixed Savings',
                amount: 43000,
              ),
              YBox(Insets.dim_30.h),
              Row(
                children: [
                  const Expanded(
                    child: DecoratedContainer(
                      title: 'Expected Interest',
                      amount: 53.2,
                    ),
                  ),
                  XBox(Insets.dim_30.w),
                  const Expanded(
                    child: DecoratedContainer(
                      title: 'Interest Earned',
                      amount: 50.2,
                    ),
                  ),
                ],
              ),
              YBox(Insets.dim_30.h),
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
                child: Text(
                  'Fixed Savings History',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.black,
                    fontSize: Insets.dim_16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              YBox(Insets.dim_14.h),
              BottomBorderWidget(
                title: 'Papa’s 70th Birthday',
                amountVested: 5000,
                interest: 50,
                maturityDate: DateTime.now(),
                status: 'Active',
                statusColor: AppColors.green,
              ).onTap(
                () {
                  param = param.copyWith(
                    title: 'Papa’s 70th Birthday',
                    status: 'Active',
                    rollover: 'Active',
                    totalAmount: 5000,
                  );
                  AppNavigator.of(context).push(
                    AppRoutes.savingDetails,
                    args: ReviewSavingsArgs(savingsDto: param),
                  );
                },
              ),
              YBox(Insets.dim_24.h),
              BottomBorderWidget(
                title: 'Matriculation',
                amountVested: 4032,
                interest: 50,
                maturityDate: DateTime.now(),
                status: 'Canceled',
                statusColor: AppColors.canceledColor,
              ).onTap(
                () {
                  param = param.copyWith(
                    title: 'Matriculation',
                    status: 'Canceled',
                    totalAmount: 5000,
                  );
                  AppNavigator.of(context).push(
                    AppRoutes.savingDetails,
                    args: ReviewSavingsArgs(savingsDto: param),
                  );
                },
              ),
              YBox(Insets.dim_24.h),
              BottomBorderWidget(
                title: 'Church Anniversary',
                amountVested: 400000,
                interest: 50,
                maturityDate: DateTime.now(),
                status: 'Matured',
                statusColor: AppColors.appPrimaryButton,
              ).onTap(
                () {
                  param = param.copyWith(
                    title: 'Church Anniversary',
                    status: 'Matured',
                    totalAmount: 5000,
                  );
                  AppNavigator.of(context).push(
                    AppRoutes.savingDetails,
                    args: ReviewSavingsArgs(savingsDto: param),
                  );
                },
              ),
              YBox(Insets.dim_24.h),
            ],
            YBox(Insets.dim_40.h),
          ],
        ),
      ),
    );
  }

  Widget _tabWidget(String title, int index) {
    return Container(
      width: context.getWidth(),
      height: Insets.dim_40.h,
      decoration: BoxDecoration(
        color: index == activeTabIndex
            ? AppColors.appPrimaryButton
            : AppColors.white,
        border: index == activeTabIndex
            ? null
            : Border.all(color: AppColors.appPrimaryButton),
        borderRadius: Corners.smBorder,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Insets.dim_12.w,
        vertical: Insets.dim_8.h,
      ),
      margin: EdgeInsets.only(
        right: Insets.dim_12.w,
      ),
      child: FittedBox(
        child: Text(
          title,
          style: context.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: Insets.dim_14.sp,
            color: index == activeTabIndex
                ? AppColors.white
                : AppColors.appPrimaryColor,
          ),
        ),
      ),
    );
  }

  Widget checkBoxWidget(
    BuildContext context, {
    required Widget widget,
  }) {
    return Row(
      children: [
        widget,
        Expanded(
          child: Text(
            'Save Beneficiary',
            style: context.textTheme.bodySmall!.copyWith(
              color: AppColors.black.withOpacity(0.7),
              fontWeight: FontWeight.w400,
              fontSize: Insets.dim_12.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _tab2Widget(String title, int index) {
    return Container(
      width: context.getWidth(),
      height: Insets.dim_40.h,
      decoration: BoxDecoration(
        border: index == active2TabIndex
            ? null
            : Border(
                bottom: BorderSide(
                color: AppColors.borderColor,
              )),
        borderRadius: Corners.smBorder,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Insets.dim_12.w,
        vertical: Insets.dim_8.h,
      ),
      margin: EdgeInsets.only(
        right: Insets.dim_12.w,
      ),
      child: FittedBox(
        child: Text(
          title,
          style: context.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: Insets.dim_16.sp,
            color: index == active2TabIndex
                ? AppColors.appPrimaryButton
                : AppColors.black.withOpacity(0.88),
          ),
        ),
      ),
    );
  }

  void showLockSheet() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: Insets.dim_20.w,
          ),
          height: context.getHeight(0.35.h),
          child: Column(
            children: [
              YBox(Insets.dim_20.h),
              LocalImage(
                lockSavingsPng,
                height: context.getHeight(0.09.h),
                width: context.getWidth(0.15.w),
              ),
              Text(
                'Lock Savings ',
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                  fontSize: Insets.dim_18.sp,
                ),
              ),
              YBox(Insets.dim_20.h),
              Text(
                'You will not have access to funds until maturity ',
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                  fontSize: Insets.dim_16.sp,
                ),
              ),
              const Spacer(),
              SafeArea(
                top: false,
                bottom: true,
                child: Row(
                  children: [
                    Expanded(
                      child: AppOutlineButton(
                        action: () => AppNavigator.of(context).pop(),
                        textTitle: 'Cancel',
                      ),
                    ),
                    XBox(Insets.dim_16.w),
                    Expanded(
                      child: AppButton(
                        textTitle: 'Continue',
                        backgroundColor: AppColors.appPrimaryButton,
                        action: () {
                          AppNavigator.of(context).pop();
                          showSuccessSheet();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showSuccessSheet() async {
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
                  const Spacer(),
                  Text(
                    'Fixed Savings Summary',
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                      fontSize: Insets.dim_18.sp,
                    ),
                  ),
                  XBox(Insets.dim_12.w),
                  Padding(
                    padding: EdgeInsets.only(left: Insets.dim_16.w),
                    child: Icon(
                      PhosphorIcons.x(PhosphorIconsStyle.bold),
                      color: AppColors.borderErrorColor,
                      size: Insets.dim_26.sp,
                    ),
                  ).onTap(() => AppNavigator.of(context).popDialog()),
                  const Spacer(),
                ],
              ),
              YBox(Insets.dim_20.h),
              previewWidget(context, 'Savings Name', 'Papa’s 70th Birthday'),
              previewWidget(context, 'Amount to Invest',
                  money.formatWithCurrencySymbol(4000)),
              previewWidget(context, 'Tenure', '30 Days'),
              previewWidget(context, 'Interest Rate', '10%'),
              previewWidget(context, 'Interest Amount',
                  money.formatWithCurrencySymbol(400)),
              previewWidget(context, 'Amount at Maturity',
                  money.formatWithCurrencySymbol(540)),
              previewWidget(context, 'Automatic Rollover',
                  showRollOver ? 'Active' : 'Inactive'),
              previewWidget(
                  context, 'Lock Savings', lockSaving ? 'Active' : 'Inactive'),
              YBox(Insets.dim_20.h),
              AppButton(
                textTitle: 'Confirm',
                backgroundColor: AppColors.appPrimaryButton,
                action: () {
                  AppNavigator.of(context).popDialog();
                  AppNavigator.of(context).push(AppRoutes.savingsToPin,
                      args: SavingsPinArgs(route: AppRoutes.savings));
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
