import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/bills/bills.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/features/transfer/transfer.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:provider/provider.dart';

class CablePaymentArgs {
  final String title;

  CablePaymentArgs({required this.title});
  factory CablePaymentArgs.empty() {
    return CablePaymentArgs(
      title: '',
    );
  }
}

class CableTopUpScreen extends StatefulWidget {
  const CableTopUpScreen({super.key, required this.args});
  final CablePaymentArgs args;

  @override
  State<CableTopUpScreen> createState() => _CableTopUpScreenState();
}

class _CableTopUpScreenState extends State<CableTopUpScreen> {
  TextEditingController accTEC = TextEditingController();
  TextEditingController bankTEC = TextEditingController();

  int? selectedIndex;

  late TransferVm vm;
  bool pChecked = false;
  bool isToggleEnabled = false;

  // TextEditingController accTEC = TextEditingController();
  // TextEditingController bankTEC = TextEditingController();
  TextEditingController amountTEC = TextEditingController();

  void _pChanged(bool? newValue) => setState(() {
        pChecked = newValue ?? false;
      });
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      vm.showBtmSheet = false;
    });
  }

  @override
  void dispose() {
    // _tabController.dispose();
    accTEC.dispose();
    bankTEC.dispose();
    amountTEC.dispose();
    super.dispose();
  }

  void _handleContinue() {
    int availableCoins = 100; // This should be fetched from actual user data
    int selectedAmount = selectedIndex != null ? (selectedIndex! + 1) * 100 : 0;

    if (isToggleEnabled) {
      if (availableCoins < selectedAmount) {
        _showInsufficientCoinsModal();
      } else {
        _navigateToNextPage();
      }
    } else {
      _navigateToNextPage();
    }
  }

  void _navigateToNextPage() {
    AppNavigator.of(context).push(
      AppRoutes.billSummary,
      args: BillSummaryArgs(
        routeTo: AppRoutes.billSummaryPin,
        sheetTitle: '${widget.args.title} Summary',
        billPinRouteTo: AppRoutes.billOptionsChoice,
      ),
    );
  }

  void _showInsufficientCoinsModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: LocalImage(
                  lockSavingsPng,
                  height: context.getHeight(0.09.h),
                  width: context.getWidth(0.15.w),
                ),
              ),
              Text(
                'Insufficient Koins',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                'You do not have enough koins to complete this action',
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: Insets.dim_18.sp,
                  color: AppColors.black.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              AppButton(
                textTitle: 'Go back',
                showLoading: vm.loading,
                action: () {
                  AppNavigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final money = context.money();
    vm = context.watch<TransferVm>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (vm.showBtmSheet && mounted) {
        AppNavigator.of(context).push(
          AppRoutes.topUpDialog,
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

    return AppScaffoldWidget(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          // direction: Axis.vertical,
          children: [
            YBox(Insets.dim_22.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.args.title,
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: Insets.dim_18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ),
            YBox(Insets.dim_18.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Source Account',
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: Insets.dim_16.sp,
                  color: AppColors.black.withOpacity(0.7),
                ),
              ),
            ),
            YBox(Insets.dim_10.h),
            const InAppSourceAccount(),
            YBox(Insets.dim_28.h),
            AppTextFormField(
              labelText: 'Smart Card Number',
              hintText: 'Enter Smart Card Number',
              inputType: TextInputType.emailAddress,
              validator: (value) => Validators.validateString()(value),
            ),
            YBox(Insets.dim_12.h),
            // ClickableFormField(
            //   labelText: 'Beneficiary',
            //   hintText: 'Select beneficiary',
            //   controller: bankTEC,
            //   suffixIcon: Icon(
            //     Icons.arrow_drop_down,
            //     color: AppColors.black,
            //     size: Insets.dim_24.sp,
            //   ),
            //   onPressed: () {
            //     showModalBottomSheet(
            //       context: context,
            //       backgroundColor: AppColors.white,
            //       shape: const RoundedRectangleBorder(
            //         borderRadius: BorderRadius.only(
            //           bottomLeft: Radius.circular(Insets.dim_20),
            //           bottomRight: Radius.circular(Insets.dim_20),
            //         ),
            //       ),
            //       builder: (context) {
            //         return SizedBox(
            //           height: context.getHeight(0.8.h),
            //           child: Column(
            //             children: [
            //               YBox(Insets.dim_12.h),
            //               Expanded(
            //                 child: ListView.builder(
            //                     itemCount: 10,
            //                     itemBuilder: (context, index) {
            //                       return Container(
            //                         height: Insets.dim_40.h,
            //                         margin: EdgeInsets.only(
            //                           bottom: Insets.dim_10.h,
            //                         ),
            //                         padding: EdgeInsets.symmetric(
            //                           horizontal: Insets.dim_10.w,
            //                           vertical: Insets.dim_8.h,
            //                         ),
            //                         decoration: BoxDecoration(
            //                           borderRadius: Corners.rsBorder,
            //                           color: index.isEven
            //                               ? AppColors.appPrimaryColor
            //                               : AppColors.white,
            //                         ),
            //                         child: Text(
            //                           index.toString(),
            //                           style: context.textTheme.bodySmall,
            //                         ),
            //                       );
            //                     }),
            //               ),
            //             ],
            //           ),
            //         );
            //       },
            //     );
            //   },
            // ),

            ClickableFormField(
              labelText: 'Beneficiary',
              hintText: 'Select beneficiary',
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
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Insets.dim_20),
                      topRight: Radius.circular(Insets.dim_20),
                    ),
                  ),
                  builder: (context) {
                    return SizedBox(
                      height: context.getHeight(0.8),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Insets.dim_20.w,
                              vertical: Insets.dim_16.h,
                            ),
                            child: Column(
                              children: [
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(
                                //       'Select Beneficiary',
                                //       style: context.textTheme.bodyMedium!
                                //           .copyWith(
                                //         fontSize: Insets.dim_16.sp,
                                //         fontWeight: FontWeight.w600,
                                //         color: AppColors.black,
                                //       ),
                                //     ),
                                //     IconButton(
                                //       onPressed: () => Navigator.pop(context),
                                //       icon: Icon(
                                //         Icons.close,
                                //         color: AppColors.black,
                                //         size: Insets.dim_24.sp,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                YBox(Insets.dim_16.h),
                                SearchTextInputField(
                                  controller: TextEditingController(),
                                  onChanged: (value) {},
                                  title: 'Search beneficiary',
                                ),
                              ],
                            ),
                          ),
                          // Divider(
                          //   color: AppColors.black.withOpacity(0.1),
                          //   thickness: 1,
                          // ),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(
                                horizontal: Insets.dim_20.w,
                                vertical: Insets.dim_8.h,
                              ),
                              itemCount: 7,
                              itemBuilder: (context, index) {
                                final colors = [
                                  Colors.orange[200],
                                  Colors.grey[200],
                                  Colors.red[200],
                                  Colors.purple[200],
                                  Colors.grey[200],
                                  Colors.orange[200],
                                  Colors.orange[200],
                                ];

                                return InkWell(
                                  onTap: () {
                                    bankTEC.text = "Adeyemi Temitope";
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: Insets.dim_12.h,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color:
                                              AppColors.black.withOpacity(0.1),
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: Insets.dim_40.w,
                                          height: Insets.dim_40.h,
                                          decoration: BoxDecoration(
                                            color: colors[index],
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              'AT',
                                              style: context
                                                  .textTheme.bodyMedium!
                                                  .copyWith(
                                                fontSize: Insets.dim_16.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        XBox(Insets.dim_12.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Adeyemi Temitope',
                                                style: context
                                                    .textTheme.bodyMedium!
                                                    .copyWith(
                                                  fontSize: Insets.dim_14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.black,
                                                ),
                                              ),
                                              YBox(Insets.dim_4.h),
                                              Text(
                                                '0034507169',
                                                style: context
                                                    .textTheme.bodyMedium!
                                                    .copyWith(
                                                  fontSize: Insets.dim_12.sp,
                                                  color: AppColors.black
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // Implement more options functionality
                                          },
                                          icon: Icon(
                                            Icons.more_vert,
                                            color: AppColors.black
                                                .withOpacity(0.6),
                                            size: Insets.dim_20.sp,
                                          ),
                                        ),
                                      ],
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
            ClickableFormField(
              labelText: 'Months of Subscription',
              hintText: 'Select number of months',
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
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Insets.dim_20),
                      bottomRight: Radius.circular(Insets.dim_20),
                    ),
                  ),
                  builder: (context) {
                    return SizedBox(
                      height: context.getHeight(0.8.h),
                      child: Column(
                        children: [
                          YBox(Insets.dim_12.h),
                          Expanded(
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: Insets.dim_40.h,
                                    margin: EdgeInsets.only(
                                      bottom: Insets.dim_10.h,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Insets.dim_10.w,
                                      vertical: Insets.dim_8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: Corners.rsBorder,
                                      color: index.isEven
                                          ? AppColors.appPrimaryColor
                                          : AppColors.white,
                                    ),
                                    child: Text(
                                      index.toString(),
                                      style: context.textTheme.bodySmall,
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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Choose Bouquet',
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.black.withOpacity(.8),
                  fontSize: Insets.dim_16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            YBox(Insets.dim_10.h),
            SizedBox(
              width: context.getWidth(0.9.w),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: Insets.dim_14.h,
                        horizontal: Insets.dim_16.w,
                      ),
                      margin: EdgeInsets.only(bottom: Insets.dim_10.h),
                      decoration: BoxDecoration(
                        borderRadius: Corners.smBorder,
                        border: Border.all(
                          color: index == selectedIndex
                              ? AppColors.appPrimaryColor
                              : AppColors.black.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              'DStv Premium Streaming Subscription ',
                              style: context.textTheme.bodySmall!.copyWith(
                                fontSize: Insets.dim_14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black.withOpacity(0.8),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(top: Insets.dim_6.h),
                            child: Text(
                              money.formatWithCurrencySymbol(
                                (index + 1) * 100,
                              ),
                              style: context.textTheme.bodySmall!.copyWith(
                                fontSize: Insets.dim_14.sp,
                                color: AppColors.black.withOpacity(0.7),
                              ),
                            ),
                          ),
                          XBox(Insets.dim_8.w),
                          Padding(
                            padding: EdgeInsets.only(top: Insets.dim_6.h),
                            child: Icon(
                              selectedIndex == index
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: selectedIndex == index
                                  ? AppColors.appPrimaryColor
                                  : AppColors.borderColor,
                              size: Insets.dim_24.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            YBox(Insets.dim_12.h),
            checkBoxWidget(
              context,
              widget: SizedBox(
                width: Insets.dim_24.w,
                height: Insets.dim_24.h,
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
            YBox(Insets.dim_12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pay with Koins',
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.black.withOpacity(0.5),
                        fontSize: Insets.dim_16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    YBox(Insets.dim_6.h),
                    Text(
                      'Bal: N100',
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.black.withOpacity(0.9),
                        fontStyle: FontStyle.italic,
                        fontSize: Insets.dim_16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: isToggleEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      isToggleEnabled = value;
                    });
                    if (value && selectedIndex != null) {
                      int selectedAmount = (selectedIndex! + 1) * 100;
                      int availableCoins =
                          100; // This should be fetched from actual user data
                      if (availableCoins < selectedAmount) {
                        _showInsufficientCoinsModal();
                        isToggleEnabled = false;
                      }
                    }
                  },
                  activeColor: AppColors.appPrimaryButton,
                  activeTrackColor: AppColors.appPrimaryButton.withOpacity(0.5),
                ),
              ],
            ),
            YBox(Insets.dim_12.h),
            AppButton(
              textTitle: 'Proceed',
              showLoading: vm.loading,
              action: _handleContinue,
            ),
            YBox(Insets.dim_50.h),
          ],
        ),
      ),
    );
  }

  Widget checkBoxWidget(
    BuildContext context, {
    required Widget widget,
  }) {
    return SizedBox(
      width: context.getWidth(0.9.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}
