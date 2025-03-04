import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/bills/bills.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/features/transfer/transfer.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:provider/provider.dart';

// class ElectricityPaymentArgs {
//   final String title;

//   ElectricityPaymentArgs({required this.title});
//   factory ElectricityPaymentArgs.empty() {
//     return ElectricityPaymentArgs(
//       title: '',
//     );
//   }
// }

class ElectricityPaymentScreen extends StatefulWidget {
  const ElectricityPaymentScreen({super.key, required this.args});
  final CablePaymentArgs args;

  @override
  State<ElectricityPaymentScreen> createState() =>
      _ElectricityPaymentScreenState();
}

class _ElectricityPaymentScreenState extends State<ElectricityPaymentScreen> {
  TextEditingController accTEC = TextEditingController();
  TextEditingController bankTEC = TextEditingController();

  int? selectedIndex;

  late TransferVm vm;
  bool pChecked = false;

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
  Widget build(BuildContext context) {
    vm = context.watch<TransferVm>();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
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
      },
    );

    return AppScaffoldWidget(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          // direction: Axis.vertical,
          children: [
            YBox(Insets.dim_22.h),
            Text(
              'Electricity',
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
            YBox(Insets.dim_28.h),
            AppTextFormField(
              labelText: 'Biller',
              hintText: 'Biller Name',
              readOnly: true,
              initialValue: widget.args.title,
              inputType: TextInputType.emailAddress,
              validator: (value) => Validators.validateString()(value),
            ),
            YBox(Insets.dim_12.h),
            AppTextFormField(
              labelText: 'Meter Name',
              hintText: 'Enter meter name',
              inputType: TextInputType.emailAddress,
              validator: (value) => Validators.validateString()(value),
            ),
            YBox(Insets.dim_12.h),
            AppTextFormField(
              labelText: 'Meter Number',
              hintText: 'Enter meter number',
              inputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) => Validators.validateString()(value),
            ),
            YBox(Insets.dim_12.h),
            ClickableFormField(
              labelText: 'Meter Type',
              hintText: 'Select meter type',
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
                    final names = ['Prepaid', 'Postpaid'];
                    return SizedBox(
                      height: context.getHeight(0.2.h),
                      child: Column(
                        children: [
                          YBox(Insets.dim_12.h),
                          Expanded(
                            child: ListView.builder(
                              itemCount: names.length,
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
                                    names[index],
                                    style: context.textTheme.bodySmall,
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
            AppTextFormField(
              labelText: 'Amount',
              hintText: 'Enter amount',
              inputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) => Validators.validateString()(value),
            ),
            YBox(Insets.dim_20.h),
            AppButton(
              textTitle: 'Proceed',
              action: () {
                AppNavigator.of(context).push(
                  AppRoutes.electricitySummary,
                  args: BillSummaryArgs(
                    routeTo: AppRoutes.electricitySummaryPin,
                    sheetTitle: '${widget.args.title} Summary',
                    billPinRouteTo: AppRoutes.electricityOptionsInputs,
                  ),
                );
              },
            ),
            YBox(Insets.dim_50.h),
          ],
        ),
      ),
    );
  }
}
