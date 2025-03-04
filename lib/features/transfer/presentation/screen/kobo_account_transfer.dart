import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/features/transfer/transfer.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class BankOrKoboAccountTransferArgs {
  final bool koboAccount;

  BankOrKoboAccountTransferArgs({required this.koboAccount});
}

class BankOrKoboAccountTransfer extends StatefulWidget {
  const BankOrKoboAccountTransfer({super.key, required this.args});
  final BankOrKoboAccountTransferArgs args;

  @override
  State<BankOrKoboAccountTransfer> createState() =>
      _BankOrKoboAccountTransferState();
}

class _BankOrKoboAccountTransferState extends State<BankOrKoboAccountTransfer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController accTEC = TextEditingController();
  TextEditingController bankTEC = TextEditingController();

  int activeTabIndex = 0;
  Map<String, String> bene = {};

  late TransferVm vm;
  bool pChecked = false;

  void _pChanged(bool? newValue) => setState(() {
        pChecked = newValue ?? false;
      });
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: 2, initialIndex: activeTabIndex);

    _tabController.addListener(() {
      setState(() {
        activeTabIndex = _tabController.index;
      });
    });
    Future.microtask(() {
      vm.showBtmSheet = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    vm = context.watch<TransferVm>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (vm.showBtmSheet && mounted) {
        AppNavigator.of(context).push(
          vm.koboAccount
              ? AppRoutes.transferDialog
              : AppRoutes.bankTransferDialog,
          args: GenericDialogueArgs(
            title: 'Success',
            icon: LocalSvgImage(successSvg),
            btn1Title: 'Generate Receipt',
            btn2Title: 'Done',
            btn1Color: AppColors.appPrimaryColor,
            btn2Color: AppColors.appPrimaryColor,
            onBtn1PressedRoute: AppRoutes.transGenericReceipt,
            onBtn2PressedRoute: AppRoutes.home,
          ),
        );
      }
    });

    Log().debug('vm.showBtmSheet is ${vm.showBtmSheet}');
    return AppScaffoldWidget(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YBox(Insets.dim_22.h),
            Text(
              'Transfer to ${widget.args.koboAccount ? 'KoboKobo Account (VFD MFB)' : 'Other Bank'}',
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: Insets.dim_16.sp,
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
            YBox(Insets.dim_16.h),
            TabBar(
              controller: _tabController,
              tabs: [
                _tabWidget('New Beneficiary', 0),
                _tabWidget('Saved Beneficiary', 1),
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
            YBox(Insets.dim_16.h),
            if (activeTabIndex == 0) ...[
              AppTextFormField(
                labelText: bene.isNotEmpty ? 'Beneficiary' : 'Account Number',
                hintText: '00000000000',
                controller: accTEC,
                validator: (value) => Validators.validateAccountNumber()(value),
                onChanged: (input) {
                  bene.clear();
                  bankTEC.clear();
                  setState(() {});
                },
              ),
              if (bene.isNotEmpty) ...[
                YBox(Insets.dim_8.h),
                Text(
                  bene['name'] ?? '',
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.appPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: Insets.dim_14.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
              YBox(Insets.dim_12.h),
              if (!widget.args.koboAccount) ...[
                ClickableFormField(
                  labelText: 'Bank',
                  hintText: 'Select Bank',
                  controller: bankTEC,
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.black,
                    size: Insets.dim_24.sp,
                  ),
                  onPressed: () {
                    if (bene.isNotEmpty) {
                      bene.clear();
                      bankTEC.clear();
                      accTEC.clear();
                      setState(() {});
                    }
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
                              SearchTextInputField(
                                title: 'Search Bank',
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: AppColors.black,
                                  size: Insets.dim_24.sp,
                                ),
                              ),
                              YBox(Insets.dim_28.h),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: Insets.dim_100.h,
                                        decoration: BoxDecoration(
                                          color: index.isEven
                                              ? AppColors.appPrimaryColor
                                              : AppColors.white,
                                        ),
                                        child: Text('Item $index'),
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
              ],
              AppTextFormField(
                labelText: 'Amount',
                hintText: '0000',
                inputType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) => Validators.validateString()(value),
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    XBox(Insets.dim_12.w),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: LocalSvgImage(nigeriaSvg),
                    ),
                    XBox(Insets.dim_12.w),
                    Container(
                      height: Insets.dim_40.h,
                      width: Insets.dim_2.w,
                      margin: EdgeInsets.symmetric(
                        vertical: Insets.dim_6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.15),
                      ),
                    ),
                    XBox(Insets.dim_12.w),
                  ],
                ),
              ),
              YBox(Insets.dim_12.h),
              AppTextFormField(
                labelText: 'Description',
                hintText: 'Enter the description',
                maxLines: 4,
                validator: (value) => Validators.validateString()(value),
              ),
              YBox(Insets.dim_6.h),
              checkBoxWidget(
                context,
                widget: SizedBox(
                  height: Insets.dim_24.h,
                  width: Insets.dim_24.w,
                  child: Checkbox(
                    onChanged: _pChanged,
                    value: pChecked,
                    shape: const RoundedRectangleBorder(
                      borderRadius: Corners.rsBorder,
                    ),
                    checkColor: AppColors.white,
                    activeColor: AppColors.black,
                  ),
                ),
              ),
            ],
            if (activeTabIndex == 1) ...[
              const SearchTextInputField(),
              YBox(Insets.dim_12.h),
              SizedBox(
                height: context.getHeight(0.4.h),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          bene = {
                            'name': 'Full Name $index',
                            'account': 'Account ${index}ber',
                          };
                          accTEC.text = 'Account ${index}ber';
                          bankTEC.text = 'Bank $index name';
                          _tabController.index = 0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Insets.dim_16.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.black.withOpacity(0.2),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              padding: EdgeInsets.all(Insets.dim_16.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(
                                  32,
                                  math.Random().nextInt(256),
                                  math.Random().nextInt(256),
                                  math.Random().nextInt(256),
                                ),
                              ),
                              child: FittedBox(
                                child: Text(
                                  'A $index B',
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: Insets.dim_16.sp,
                                  ),
                                ),
                              ),
                            ),
                            XBox(Insets.dim_14.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Full Name $index',
                                    style:
                                        context.textTheme.bodySmall!.copyWith(
                                      fontSize: Insets.dim_14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black.withOpacity(0.8),
                                    ),
                                  ),
                                  YBox(Insets.dim_8.h),
                                  Text(
                                    'Account ${index}ber',
                                    style:
                                        context.textTheme.bodySmall!.copyWith(
                                      fontSize: Insets.dim_14.sp,
                                      color: AppColors.black.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              PhosphorIcons.dotsThreeOutlineVertical(
                                PhosphorIconsStyle.fill,
                              ),
                              color: AppColors.borderColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
            YBox(Insets.dim_12.h),
            AppButton(
              textTitle: 'Continue',
              action: () {
                if (vm.koboAccount) {
                  AppNavigator.of(context).push(AppRoutes.transferSummary);
                } else {
                  AppNavigator.of(context).push(AppRoutes.bankTransferSummary);
                }
              },
            ),
            YBox(Insets.dim_50.h),
          ],
        ),
      ),
    );
  }

  Widget _tabWidget(String title, int index) {
    return Container(
      width: context.getWidth(),
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
        horizontal: Insets.dim_24.w,
        vertical: Insets.dim_12.h,
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
        XBox(Insets.dim_12.w),
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
}
