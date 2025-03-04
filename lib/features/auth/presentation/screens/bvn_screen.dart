import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/functional_util/assets.dart';
import 'package:kobo_kobo/functional_util/extensions/extensions.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class BvnScreen extends StatefulWidget {
  const BvnScreen({super.key});

  @override
  State<BvnScreen> createState() => _BvnScreenState();
}

class _BvnScreenState extends State<BvnScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(
        centerTitle: true,
        showLeading: true,
        useSmallFont: true,
        title: '2/3',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BVN Verification',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.black.withOpacity(.88),
              fontSize: Insets.dim_24.sp,
            ),
            textAlign: TextAlign.start,
          ),
          YBox(Insets.dim_70.h),
          Center(
            child: LocalImage(
              bvnPersonPng,
              height: context.getHeight(0.15),
            ),
          ),
          YBox(Insets.dim_16.h),
          Center(
            child: Text(
              'Please take a selfie',
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.black.withOpacity(.88),
                fontSize: Insets.dim_14.sp,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const Spacer(),
          AppButton(
            textTitle: 'Take Selfie',
            action: () => AppNavigator.of(context).push(AppRoutes.bvnPinLock),
          ),
          YBox(Insets.dim_34.h),
        ],
      ),
    );
  }
}
