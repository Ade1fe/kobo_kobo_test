import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/bills/bills.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/features/transfer/transfer.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:provider/provider.dart';

class BillsOptionsScreen extends StatefulWidget {
  const BillsOptionsScreen({super.key});

  @override
  State<BillsOptionsScreen> createState() => _BillsOptionsScreenState();
}

class _BillsOptionsScreenState extends State<BillsOptionsScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BillsVm>();
    final transferVm = context.watch<TransferVm>();
    return AppScaffoldWidget(
      appBar: const CustomAppBar(showLeading: true),
      body: SingleChildScrollView(
        child: Column(
          // Change Wrap to Column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bills',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.black.withOpacity(.88),
                fontSize: Insets.dim_24.sp,
              ),
              textAlign: TextAlign.start,
            ),
            YBox(Insets.dim_24.h),
            Text(
              'Category',
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.black.withOpacity(.88),
                fontSize: Insets.dim_14.sp,
              ),
              textAlign: TextAlign.start,
            ),
            YBox(Insets.dim_18.h),
            SizedBox(
              width: context.getWidth(1.w),
              child: const SearchTextInputField(),
            ),
            YBox(Insets.dim_30.h),
            ListView.builder(
              itemCount: vm.billsOptions.length,
              shrinkWrap:
                  true, // Keep shrinkWrap to avoid infinite height issues
              controller: scrollController,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final option = vm.billsOptions[index];
                return GestureDetector(
                  onTap: () {
                    if (option.name.toLowerCase().contains('airtime')) {
                      transferVm.activeIndex = 0;
                    } else if (option.name.toLowerCase().contains('data')) {
                      transferVm.activeIndex = 1;
                    } else if (option.name
                        .toLowerCase()
                        .contains('electricity')) {
                      AppNavigator.of(context).push(
                        option.route,
                        args: CableOptionsArgs(
                          title: option.name,
                          options: vm.eleOptions,
                        ),
                      );
                    } else if (option.name.toLowerCase().contains('cable')) {
                      AppNavigator.of(context).push(
                        option.route,
                        args: CableOptionsArgs(
                            title: option.name, options: vm.cableOptions),
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Insets.dim_24.w,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: index == vm.billsOptions.length - 1
                              ? AppColors.white
                              : AppColors.appPrimaryColor.withOpacity(0.2),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(Insets.dim_4.sp),
                          height: Insets.dim_40.h,
                          width: Insets.dim_40.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: option.color!.withOpacity(0.5),
                            border: Border.all(
                              color: option.color!,
                            ),
                          ),
                          child: Center(
                            child: LocalSvgImage(
                              option.icon,
                            ),
                          ),
                        ),
                        XBox(Insets.dim_12.w),
                        Expanded(
                          child: Text(
                            option.name,
                            style: context.textTheme.bodySmall!.copyWith(
                              color: AppColors.black,
                              fontSize: Insets.dim_14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right,
                          color: AppColors.black,
                          size: Insets.dim_26.sp,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
