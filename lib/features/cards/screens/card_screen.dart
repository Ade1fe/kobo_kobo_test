import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../functional_util/functional_utils.dart';
import '../../../ui_widgets/ui_widgets.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(showLeading: true),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(1.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Debit Cards',
                        style: context.textTheme.bodySmall!.copyWith(
                          fontSize: Insets.dim_24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _buildProfileImage(),
                    ],
                  ),
                  const Divider(height: 1, thickness: 1.0),
                  SizedBox(height: 20.h),
                  Align(
                    child: LocalImage(
                      cardImg,
                      height: 0.3.sh,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildAddNewContent()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(8.w),
        child: ClipOval(
          child: LocalImage(
            empProfilePic,
            width: 40.w,
            height: 40.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildAddNewContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Coming Soon!',
          style: context.textTheme.bodyMedium!.copyWith(
            fontSize: Insets.dim_16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 20.h),
        _buildBulletPoint(
            'Get your instant Kobokobo Virtual Card in a few clicks'),
        SizedBox(height: 20.h),
        _buildBulletPoint('Experience total convenience'),
        SizedBox(height: 20.h),
        _buildBulletPoint('Pay for items anywhere and anytime'),
        SizedBox(height: 20.h),
        _buildBulletPoint('24/7 support'),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Icon(Icons.circle, size: 8.sp, color: AppColors.black.withOpacity(0.7)),
        LocalImage(
          pointerImg,
          width: 15.w,
          height: 12.h,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: context.textTheme.bodySmall!.copyWith(
              fontSize: Insets.dim_16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black.withOpacity(0.6),
            ),
          ),
        ),
      ],
    );
  }
}
