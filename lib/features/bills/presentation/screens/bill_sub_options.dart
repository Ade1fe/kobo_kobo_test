import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/bills/bills.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:provider/provider.dart';

class CableOptionsArgs {
  final String title;
  final List<BillsOptionModel> options;

  CableOptionsArgs({required this.title, required this.options});

  factory CableOptionsArgs.empty() {
    return CableOptionsArgs(
      title: '',
      options: [],
    );
  }
}

class CableOptions extends StatefulWidget {
  const CableOptions({super.key, required this.args});
  final CableOptionsArgs args;

  @override
  State<CableOptions> createState() => _CableOptionsState();
}

class _CableOptionsState extends State<CableOptions> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BillsVm>();

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
            const SearchTextInputField(),
            SizedBox(
              width: context.getWidth(0.9.w),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.args.options.length,
                itemBuilder: (BuildContext context, int index) {
                  final option = widget.args.options[index];
                  return GestureDetector(
                    onTap: () => AppNavigator.of(context).push(
                      option.route,
                      args: CablePaymentArgs(title: option.name),
                    ),
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
                            height: Insets.dim_60.h,
                            width: Insets.dim_60.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == 0 || index == 1
                                  ? AppColors.white
                                  : option.color ?? AppColors.white,
                              border: Border.all(
                                color: option.color!,
                              ),
                            ),
                            child: Center(
                              child: LocalImage(
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
            ),
          ],
        ),
      ),
    );
  }
}
