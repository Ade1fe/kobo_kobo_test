import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/functional_util/extensions/extensions.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class PersonalInfoCountry extends StatefulWidget {
  const PersonalInfoCountry({super.key});

  @override
  State<PersonalInfoCountry> createState() => _PersonalInfoCountryState();
}

class _PersonalInfoCountryState extends State<PersonalInfoCountry> {
  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(
        centerTitle: true,
        showLeading: true,
        useSmallFont: true,
        title: '1/3',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.black.withOpacity(.88),
              fontSize: Insets.dim_24.sp,
            ),
            textAlign: TextAlign.start,
          ),
          YBox(Insets.dim_14.h),
          const ClickableFormField(
            labelText: 'Country',
            hintText: 'Nigeria',
          ),
          YBox(Insets.dim_12.h),
          const ClickableFormField(
            labelText: 'State',
            hintText: 'Select your state',
          ),
          YBox(Insets.dim_12.h),
          const ClickableFormField(
            labelText: 'LGA',
            hintText: 'Select your LGA',
          ),
          YBox(Insets.dim_12.h),
          const AppTextFormField(
            maxLines: 4,
            labelText: 'Address',
            hintText: 'Enter your home address',
          ),
          YBox(Insets.dim_60.h),
          AppButton(
              textTitle: 'Continue',
              action: () => AppNavigator.of(context).push(AppRoutes.signUpBvn))
        ],
      ),
    );
  }
}
