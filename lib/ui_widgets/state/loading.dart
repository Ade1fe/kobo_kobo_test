import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:flutter/material.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({this.size = 15, this.color, super.key});
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: color ?? AppColors.appPrimaryColor,
        ),
      ),
    );
  }
}

class AppLinearLoadingWidget extends StatefulWidget {
  const AppLinearLoadingWidget({super.key, this.color});
  final Color? color;

  @override
  State<AppLinearLoadingWidget> createState() => _AppLinearLoadingWidget();
}

class _AppLinearLoadingWidget extends State<AppLinearLoadingWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: 1.seconds,
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: controller.value,
      backgroundColor: AppColors.white,
      valueColor: AlwaysStoppedAnimation<Color>(
        widget.color ?? AppColors.appPrimaryColor,
      ),
      semanticsLabel: 'loading progress indicator',
    );
  }
}
