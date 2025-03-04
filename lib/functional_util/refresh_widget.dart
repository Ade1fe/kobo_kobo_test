import 'dart:io';

import 'package:flutter/material.dart';

class RefreshWidget extends StatefulWidget {
  const RefreshWidget({
    super.key,
    required this.onRefresh,
    required this.child,
    this.scrollController,
  });

  final Widget child;
  final Future Function() onRefresh;
  final ScrollController? scrollController;

  @override
  _RefreshWidgetState createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) =>
      Platform.isAndroid ? buildAndroidList() : buildIOSList();

  Widget buildAndroidList() => RefreshIndicator(
        onRefresh: widget.onRefresh,
        child: widget.child,
      );

  Widget buildIOSList() => RefreshIndicator(
        onRefresh: widget.onRefresh,
        child: widget.child,
      );
}
