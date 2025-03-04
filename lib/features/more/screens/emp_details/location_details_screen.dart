// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kobo_kobo/functional_util/extensions/context_extension.dart';
// import 'package:kobo_kobo/functional_util/extensions/string.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// // import 'package:kobo_kobo/ui_widgets/app_scaffold.dart';
// // import 'package:kobo_kobo/ui_widgets/constants/numbers.dart';
// // import 'package:kobo_kobo/ui_widgets/image.dart';
// // import 'package:kobo_kobo/ui_widgets/textfields/app_textfield.dart';
// // import 'package:kobo_kobo/ui_widgets/textfields/date_picker_form_field.dart';
// import 'package:dotted_border/dotted_border.dart';
// // import '../../../../functional_util/assets.dart';
// // import '../../../../ui_widgets/app_button.dart';
// // import '../../../../ui_widgets/constants/constants.dart';
// import '../../../../ui_widgets/ui_widgets.dart';

// class LocationDetailsScreen extends StatefulWidget {
//   const LocationDetailsScreen({super.key});

//   @override
//   _LocationDetailsScreenState createState() => _LocationDetailsScreenState();
// }

//   final Map<String, List<String>> _statesAndLGAs = {
//     'Abia': ['Aba North', 'Aba South', 'Arochukwu'],
//     'Adamawa': ['Demsa', 'Fufure', 'Ganye'],
//     'Akwa Ibom': ['Abak', 'Eastern Obolo', 'Eket'],
//   };

// class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
//   // final _formKey = GlobalKey<FormState>();
//   String? _selectedFilePath;
//   final TextEditingController _stateController = TextEditingController();
//   final TextEditingController _lgaController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();

//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowMultiple: false,
//     );

//     if (result != null) {
//       setState(() {
//         _selectedFilePath = result.files.single.path;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     // Dispose controllers to avoid memory leaks
//     _stateController.dispose();
//     _lgaController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AppScaffoldWidget(
//       appBar: const CustomAppBar(
//         showLeading: true,
//         leadingColor: AppColors.black,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(1.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Employment Details',
//                   style: context.textTheme.bodySmall!.copyWith(
//                     fontSize: Insets.dim_24.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 14.h),
//                 const Divider(height: 1, thickness: 1.0),
//                 SizedBox(height: 24.h),
//                 Text(
//                   "Additional Information",
//                   style: context.textTheme.bodyMedium!.copyWith(
//                     fontSize: Insets.dim_18.sp,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.black.withOpacity(0.8),
//                   ),
//                 ),
//                 SizedBox(height: 24.h),
//                 ClickableFormField(
//                   labelText: 'State',
//                   hintText: 'Select employer\'s state',
//                   controller: _stateController,
//                   onPressed: () {},
//                 ),
//                 SizedBox(height: 16.h),
//                 ClickableFormField(
//                   labelText: 'LGA',
//                   hintText: 'Select employer\'s LGA',
//                   controller: _lgaController,
//                   onPressed: () {},
//                 ),
//                 SizedBox(height: 16.h),
//                 AppTextFormField(
//                   labelText: 'Address',
//                   hintText: 'Enter your employer\'s address',
//                   controller: _addressController,
//                   maxLines: 5,
//                 ),
//                 SizedBox(height: 16.h),
//                 Text(
//                   "Upload ID Card",
//                   style: TextStyle(
//                     fontSize: Insets.dim_16.sp,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.black,
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 DragTarget<String>(
//                   builder: (context, candidateData, rejectedData) {
//                     return InkWell(
//                       onTap: _pickFile,
//                       child: DottedBorder(
//                         borderType: BorderType.RRect,
//                         // radius: const Radius.circular(12),
//                         color: AppColors.black.withOpacity(0.2),
//                         strokeWidth: 2,
//                         dashPattern: const [8, 4],
//                         child: Container(
//                           width: double.infinity,
//                           height: 120.h,
//                           decoration: BoxDecoration(
//                             // color: AppColors.appPrimaryColor.withOpacity(0.05),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.cloud_upload,
//                                 // color: AppColors.appPrimaryColor,
//                                 size: 40.sp,
//                               ),
//                               SizedBox(height: 8.h),
//                               if (_selectedFilePath != null)
//                                 Text(
//                                   _selectedFilePath!.routeSplitter(),
//                                   style: context.textTheme.bodySmall!.copyWith(
//                                     color: AppColors.black.withOpacity(0.88),
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: Insets.dim_18.sp,
//                                   ),
//                                 )
//                               else
//                                 Text(
//                                   'Take a picture to upload file or',
//                                   style: context.textTheme.bodySmall!.copyWith(
//                                     color: AppColors.black.withOpacity(0.5),
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: Insets.dim_16.sp,
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                   onAcceptWithDetails: (data) {
//                     setState(() {
//                       _selectedFilePath = data as String?;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 40.h),
//                 // AppPrimaryButton(
//                 //   textTitle: 'Submit',
//                 //   action: () {},
//                 // ),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50.h,
//                   child: AppPrimaryButton(
//                     action: () {
//                       showTopSnackBar(
//                           context, 'Employment Details Submitted Successfully');
//                     },
//                     textTitle: 'Send',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void showTopSnackBar(BuildContext context, String message) {
//     final overlay = Overlay.of(context);

//     final overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: 50.0,
//         left: 0.0,
//         right: 0.0,
//         child: Material(
//           color: Colors.transparent,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//               decoration: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       PhosphorIcons.checkCircle(),
//                       size: 24.sp,
//                       color: AppColors.white,
//                     ),
//                     onPressed: () {
//                       // overlayEntry.remove();
//                     },
//                   ),
//                   Expanded(
//                     child: Text(
//                       message,
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       PhosphorIcons.xCircle(),
//                       size: 24.sp,
//                       color: AppColors.white,
//                     ),
//                     onPressed: () {
//                       // overlayEntry.remove();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );

//     overlay.insert(overlayEntry);

//     Future.delayed(const Duration(seconds: 3), () {
//       overlayEntry.remove();
//     });
//   }
// }

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/functional_util/extensions/context_extension.dart';
import 'package:kobo_kobo/functional_util/extensions/string.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../../ui_widgets/ui_widgets.dart';

class LocationDetailsScreen extends StatefulWidget {
  const LocationDetailsScreen({super.key});

  @override
  _LocationDetailsScreenState createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedFilePath;
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _lgaController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedState;
  String? _selectedLGA;

  final Map<String, List<String>> _statesAndLGAs = {
    'Abia': ['Aba North', 'Aba South', 'Arochukwu'],
    'Adamawa': ['Demsa', 'Fufure', 'Ganye'],
    'Akwa Ibom': ['Abak', 'Eastern Obolo', 'Eket'],
  };

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

  void _showStateSelection() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select State',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: _statesAndLGAs.length,
                  itemBuilder: (context, index) {
                    String state = _statesAndLGAs.keys.elementAt(index);
                    return ListTile(
                      title: Text(state),
                      onTap: () {
                        setState(() {
                          _selectedState = state;
                          _selectedLGA = null;
                          _stateController.text = state;
                          _lgaController.text = '';
                        });
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

  void _showLGASelection() {
    if (_selectedState == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a state first')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select LGA',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: _statesAndLGAs[_selectedState]?.length ?? 0,
                  itemBuilder: (context, index) {
                    String lga = _statesAndLGAs[_selectedState]![index];
                    return ListTile(
                      title: Text(lga),
                      onTap: () {
                        setState(() {
                          _selectedLGA = lga;
                          _lgaController.text = lga;
                        });
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

  @override
  void dispose() {
    _stateController.dispose();
    _lgaController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: const CustomAppBar(
        showLeading: true,
        leadingColor: AppColors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(1.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Employment Details',
                    style: context.textTheme.bodySmall!.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  const Divider(height: 1, thickness: 1.0),
                  SizedBox(height: 24.h),
                  Text(
                    "Additional Information",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ClickableFormField(
                    labelText: 'State',
                    hintText: 'Select employer\'s state',
                    controller: _stateController,
                    onPressed: _showStateSelection,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a state';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  ClickableFormField(
                    labelText: 'LGA',
                    hintText: 'Select employer\'s LGA',
                    controller: _lgaController,
                    onPressed: _showLGASelection,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an LGA';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  AppTextFormField(
                    labelText: 'Address',
                    hintText: 'Enter your employer\'s address',
                    controller: _addressController,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Upload ID Card",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  InkWell(
                    onTap: _pickFile,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      color: AppColors.black.withOpacity(0.2),
                      strokeWidth: 2,
                      dashPattern: const [8, 4],
                      child: Container(
                        width: double.infinity,
                        height: 150.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_upload,
                              color: AppColors.black.withOpacity(0.5),
                              size: 40.sp,
                            ),
                            SizedBox(height: 8.h),
                            if (_selectedFilePath != null)
                              Text(
                                _selectedFilePath!.routeSplitter(),
                                style: context.textTheme.bodySmall!.copyWith(
                                  color: AppColors.black.withOpacity(0.88),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                ),
                              )
                            else
                              Column(
                                children: [
                                  Text(
                                    'Take a picture to upload file or',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color:
                                              AppColors.black.withOpacity(0.5),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                        ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 6.h),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              AppColors.black.withOpacity(0.3)),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.arrow_upward,
                                          size: 16.sp,
                                          color: AppColors.black,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          'Browse file',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: AppColors.black
                                                    .withOpacity(0.9),
                                                fontWeight: FontWeight.w500,
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
                  ),
                  SizedBox(height: 40.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: AppPrimaryButton(
                      action: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Employment Details Submitted Successfully')),
                          );
                        }
                      },
                      textTitle: 'Submit',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
