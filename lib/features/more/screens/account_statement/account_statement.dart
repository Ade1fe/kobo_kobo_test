import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/more/screens/account_statement/third_party/third_party.dart';
import 'package:kobo_kobo/features/more/screens/account_statement/selfscreen/self_screen.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';

import '../../../../ui_widgets/ui_widgets.dart';

class AccountStatement extends StatefulWidget {
  const AccountStatement({super.key});

  @override
  State<AccountStatement> createState() => _AccountStatementState();
}

class _AccountStatementState extends State<AccountStatement>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTabButton(String title, int index) {
    return Expanded(
      // Wrap with Expanded
      child: GestureDetector(
        onTap: () {
          setState(() {
            _tabController.index = index;
          });
        },
        child: Container(
          height: Insets.dim_40.h,
          decoration: BoxDecoration(
            color: index == _tabController.index
                ? AppColors.appPrimaryButton
                : AppColors.white,
            border: index == _tabController.index
                ? null
                : Border.all(color: AppColors.appPrimaryButton),
            borderRadius: Corners.smBorder,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Insets.dim_12.w,
            vertical: Insets.dim_8.h,
          ),
          margin: EdgeInsets.only(
            right: index == 0 ? Insets.dim_12.w : 0,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: Insets.dim_14.sp,
                    color: index == _tabController.index
                        ? AppColors.white
                        : AppColors.appPrimaryColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(showLeading: true),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Statement',
                    style: context.textTheme.bodySmall!.copyWith(
                      fontSize: Insets.dim_24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  const Divider(height: 1, thickness: 1.0),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
              child: Row(
                children: [
                  _buildTabButton('To Self', 0),
                  _buildTabButton('To Third Party', 1),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Self Tab Content
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4.h),
                          const SelfScreen(),
                        ],
                      ),
                    ),
                  ),
                  // To Third Party Tab Content
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4.h),
                          const ThirdParty(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
