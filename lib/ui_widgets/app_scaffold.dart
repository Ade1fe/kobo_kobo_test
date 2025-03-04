// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kobo_kobo/functional_util/functional_utils.dart';
// import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

// class AppScaffoldWidget extends StatefulWidget {
//   const AppScaffoldWidget({
//     super.key,
//     this.appBar,
//     required this.body,
//     this.backgroundColor = AppColors.white,
//     this.bottomNavigationBar,
//     this.useBg = true,
//   });
//   final PreferredSizeWidget? appBar;
//   final Widget body;
//   final Color? backgroundColor;
//   final Widget? bottomNavigationBar;
//   final bool useBg;

//   @override
//   State<AppScaffoldWidget> createState() => _AppScaffoldWidgetState();
// }

// class _AppScaffoldWidgetState extends State<AppScaffoldWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: widget.backgroundColor,
//       appBar: widget.appBar,
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           if (widget.useBg) Center(child: LocalImage(scaffoldBgPng)),
//           Padding(
//             padding: EdgeInsets.only(
//               left: Insets.dim_16.w,
//               right: Insets.dim_16.w,
//               top: widget.appBar == null ? Insets.dim_14.h : Insets.dim_12.h,
//             ),
//             child: widget.body,
//           ),
//         ],
//       ),
//       bottomNavigationBar: widget.bottomNavigationBar,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class AppScaffoldWidget extends StatefulWidget {
  const AppScaffoldWidget({
    super.key,
    this.appBar,
    required this.body,
    this.backgroundColor = AppColors.white,
    this.bottomNavigationBar,
    this.useBg = true,
    this.padding,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final bool useBg;
  final EdgeInsetsGeometry? padding;

  @override
  State<AppScaffoldWidget> createState() => _AppScaffoldWidgetState();
}

class _AppScaffoldWidgetState extends State<AppScaffoldWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: widget.appBar,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          if (widget.useBg) Center(child: LocalImage(scaffoldBgPng)),
          Padding(
            padding: widget.padding ??
                EdgeInsets.only(
                  left: Insets.dim_16.w,
                  right: Insets.dim_16.w,
                  top:
                      widget.appBar == null ? Insets.dim_14.h : Insets.dim_12.h,
                ),
            child: widget.body,
          ),
        ],
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
