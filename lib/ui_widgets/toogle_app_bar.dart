import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/ui_widgets/constants/constants.dart';
import 'package:kobo_kobo/ui_widgets/constants/numbers.dart';

class ToggleAppBar extends StatelessWidget {
  final bool isEligibilityCheck;
  final Function(bool) onToggle;

  const ToggleAppBar({
    super.key,
    required this.isEligibilityCheck,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 110.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: isEligibilityCheck
                      ? Colors.grey[300]
                      : const Color.fromARGB(255, 60, 199, 29),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => onToggle(true),
                    child: CircleAvatar(
                      radius: 7.r,
                      backgroundColor: isEligibilityCheck
                          ? AppColors.appPrimaryColor
                          : (isEligibilityCheck
                              ? Colors.grey[300]
                              : const Color.fromARGB(255, 60, 199,
                                  29)), // Changes when Loan Application is clicked
                    ),
                  ),
                  SizedBox(width: 110.w),
                  GestureDetector(
                    onTap: () => onToggle(false),
                    child: CircleAvatar(
                      radius: 7.r,
                      backgroundColor: !isEligibilityCheck
                          ? AppColors.appPrimaryColor
                          : Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 8.h),

          /// The Texts
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => onToggle(true),
                child: Text(
                  'Eligibility Check',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Insets.dim_8.sp,
                    color: isEligibilityCheck
                        ? AppColors.appPrimaryColor
                        : const Color.fromARGB(255, 60, 199, 29),
                  ),
                ),
              ),
              SizedBox(width: 90.w),
              GestureDetector(
                onTap: () => onToggle(false),
                child: Text(
                  'Loan Application',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Insets.dim_8.sp,
                    color: isEligibilityCheck
                        ? Colors.grey
                        : AppColors.appPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
