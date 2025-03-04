import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class RegConApp extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(Map<String, dynamic>) onSubmit;

  const RegConApp({
    super.key,
    required this.formData,
    required this.onSubmit,
  });

  @override
  _RegConAppState createState() => _RegConAppState();
}

class _RegConAppState extends State<RegConApp> {
  final Map<String, List<String>> _statesAndLGAs = {
    'Abia': [
      'Aba North',
      'Aba South',
      'Arochukwu',
      'Bende',
      'Ikwuano',
      'Isiala Ngwa North',
      'Isiala Ngwa South',
      'Isuikwuato',
      'Obi Ngwa',
      'Ohafia',
      'Osisioma',
      'Ugwunagbo',
      'Ukwa East',
      'Ukwa West',
      'Umuahia North',
      'Umuahia South',
      'Umu Nneochi'
    ],
    'Adamawa': [
      'Demsa',
      'Fufure',
      'Ganye',
      'Girei',
      'Gombi',
      'Guyuk',
      'Hong',
      'Jada',
      'Lamurde',
      'Madagali',
      'Maiha',
      'Mayo Belwa',
      'Michika',
      'Mubi North',
      'Mubi South',
      'Numan',
      'Shelleng',
      'Song',
      'Toungo',
      'Yola North',
      'Yola South'
    ],
    'Akwa Ibom': [
      'Abak',
      'Eastern Obolo',
      'Eket',
      'Esit Eket',
      'Essien Udim',
      'Etim Ekpo',
      'Etinan',
      'Ibeno',
      'Ibesikpo Asutan',
      'Ibiono-Ibom',
      'Ika',
      'Ikono',
      'Ikot Abasi',
      'Ikot Ekpene',
      'Ini',
      'Itu',
      'Mbo',
      'Mkpat-Enin',
      'Nsit-Atai',
      'Nsit-Ibom',
      'Nsit-Ubium',
      'Obot Akara',
      'Okobo',
      'Onna',
      'Oron',
      'Oruk Anam',
      'Udung-Uko',
      'Ukanafun',
      'Uruan',
      'Urue-Offong/Oruko',
      'Uyo'
    ],
    'Anambra': [
      'Aguata',
      'Anambra East',
      'Anambra West',
      'Anaocha',
      'Awka North',
      'Awka South',
      'Ayamelum',
      'Dunukofia',
      'Ekwusigo',
      'Idemili North',
      'Idemili South',
      'Ihiala',
      'Njikoka',
      'Nnewi North',
      'Nnewi South',
      'Ogbaru',
      'Onitsha North',
      'Onitsha South',
      'Orumba North',
      'Orumba South',
      'Oyi'
    ],
    'Bauchi': [
      'Alkaleri',
      'Bauchi',
      'Bogoro',
      'Damban',
      'Darazo',
      'Dass',
      'Gamawa',
      'Ganjuwa',
      'Giade',
      'Itas/Gadau',
      'Jama\'are',
      'Katagum',
      'Kirfi',
      'Misau',
      'Ningi',
      'Shira',
      'Tafawa Balewa',
      'Toro',
      'Warji',
      'Zaki'
    ],
    // Add more states and their LGAs here...
  };

  String? _selectedState;
  String? _selectedLGA;
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _lgaController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedFilePath;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final combinedData = {
        ...widget.formData,
        'state': _selectedState,
        'lga': _selectedLGA,
        'address': _addressController.text,
        'idCardPath': _selectedFilePath,
      };
      widget.onSubmit(combinedData);
      _showSuccessModal();
    }
  }

  void _showSuccessModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: LocalImage(
                    successPng,
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: Insets.dim_26.w),
                    child: Text(
                      'Your employment details have been registered You can now apply for a loan. Receive your salary for the next 3 months with Kobokobo to qualify for a loan',
                      style: TextStyle(
                        fontSize: Insets.dim_16.sp,
                        fontWeight: FontWeight.w200,
                        color: AppColors.black,
                      ),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(height: 24.h),
                AppPrimaryButton(
                  textTitle: "Done",
                  action: () => AppNavigator.of(context).push(AppRoutes.loans),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _selectedFilePath = result.files.single.path;
      });
    }
  }

  void _showSelectionBottomSheet(
      String title, List<String> items, Function(String) onSelect) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: Insets.dim_18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(items[index]),
                      onTap: () {
                        onSelect(items[index]);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showStateBottomSheet() {
    _showSelectionBottomSheet(
      'Select State',
      _statesAndLGAs.keys.toList(),
      (state) {
        setState(() {
          _selectedState = state;
          _stateController.text = state;
          _selectedLGA = null;
          _lgaController.clear();
        });
      },
    );
  }

  void _showLGABottomSheet() {
    if (_selectedState == null) return;

    _showSelectionBottomSheet(
      'Select LGA',
      _statesAndLGAs[_selectedState] ?? [],
      (lga) {
        setState(() {
          _selectedLGA = lga;
          _lgaController.text = lga;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Loans',
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontSize: Insets.dim_18.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(height: 18.h),
                        Text(
                          'Additional Information',
                          style: TextStyle(
                            fontSize: Insets.dim_18.sp,
                            fontWeight: FontWeight.w100,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 22.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClickableFormField(
                            labelText: 'State',
                            hintText: 'Select employer\'s state',
                            controller: _stateController,
                            onPressed: _showStateBottomSheet,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please select a state'
                                : null,
                          ),
                          SizedBox(height: 16.h),
                          ClickableFormField(
                            labelText: 'LGA',
                            hintText: 'Select employer\'s LGA',
                            controller: _lgaController,
                            onPressed: _selectedState != null
                                ? _showLGABottomSheet
                                : null,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please select an LGA'
                                : null,
                          ),
                          SizedBox(height: 16.h),
                          AppTextFormField(
                            labelText: 'Address',
                            hintText: 'Enter your employer\'s address',
                            controller: _addressController,
                            maxLines: 5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "Upload ID Card",
                            style: context.textTheme.bodySmall!.copyWith(
                              fontSize: Insets.dim_16.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          DragTarget<String>(
                            builder: (context, candidateData, rejectedData) {
                              return InkWell(
                                onTap: _pickFile,
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  // radius: const Radius.circular(12),
                                  // color: AppColors.appPrimaryColor,
                                  color: AppColors.black.withOpacity(0.2),
                                  strokeWidth: 2,
                                  dashPattern: const [8, 4],
                                  child: Container(
                                    width: double.infinity,
                                    height: 150.h,
                                    decoration: BoxDecoration(
                                      // color: AppColors.appPrimaryColor
                                      //     .withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.cloud_upload,
                                          color:
                                              AppColors.black.withOpacity(0.5),
                                          size: 40.sp,
                                        ),
                                        SizedBox(height: 8.h),
                                        if (_selectedFilePath != null)
                                          Text(
                                              _selectedFilePath!
                                                  .routeSplitter(),
                                              style: context
                                                  .textTheme.bodySmall!
                                                  .copyWith(
                                                color: AppColors.black
                                                    .withOpacity(0.88),
                                                fontWeight: FontWeight.w500,
                                                fontSize: Insets.dim_18.sp,
                                              ))
                                        else
                                          Column(
                                            children: [
                                              Text(
                                                'Take a picture to upload file or',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: AppColors.black
                                                          .withOpacity(0.5),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16.sp,
                                                    ),
                                              ),
                                              SizedBox(height: 8.h),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.w,
                                                    vertical: 6.h),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      // color: AppColors.black
                                                      color: AppColors.black
                                                          .withOpacity(0.6)),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.arrow_upward,
                                                        size: 16.sp,
                                                        color: AppColors.black
                                                        // .withOpacity(0.9),
                                                        ),
                                                    SizedBox(width: 4.w),
                                                    Text(
                                                      'Browse file',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                            color: AppColors
                                                                .black
                                                                .withOpacity(
                                                                    0.9),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16.sp,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            onAcceptWithDetails: (data) {
                              setState(() {
                                _selectedFilePath = data as String?;
                              });
                            },
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  textTitle: "Submit",
                  action: _submitForm,
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
