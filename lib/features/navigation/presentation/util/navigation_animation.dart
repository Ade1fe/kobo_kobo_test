import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kobo_kobo/functional_util/extensions/extensions.dart';

class CustomPageTransition extends CustomTransitionPage {
  CustomPageTransition({
    required this.widget,
    required this.direction,
    required this.pageKey,
    required this.durationInMillIs,
    this.useSlideTransition = true,
  }) : super(
          child: widget,
          key: pageKey,
          transitionDuration: durationInMillIs.milliseconds,
          fullscreenDialog: true,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return useSlideTransition
                ? SlideTransition(
                    position: Tween<Offset>(
                      begin: AxisDirection.up == direction
                          ? const Offset(0, 1)
                          : AxisDirection.down == direction
                              ? const Offset(0, -1)
                              : AxisDirection.right == direction
                                  ? const Offset(-1, 0)
                                  : const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  )
                : FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
          },
        );
  final Widget widget;
  final LocalKey pageKey;
  final AxisDirection direction;
  final int durationInMillIs;
  final bool useSlideTransition;
}
