import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimationListView extends StatefulWidget {
  const AnimationListView({super.key, this.index, required this.child});
  final int? index;

  final Widget child;

  @override
  _AnimationListViewState createState() => _AnimationListViewState();
}

class _AnimationListViewState extends State<AnimationListView> {
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: widget.index ?? 10,
      duration: const Duration(milliseconds: 300),
      child: SlideAnimation(
        verticalOffset: 50,
        child: FadeInAnimation(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
          child: widget.child,
        ),
      ),
    );
  }
}

class ListItem<T> {
  ListItem(this.data);
  bool selected = false;
  T data;
}
