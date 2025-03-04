import 'package:flutter/material.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class ExchangeRateSkeleton extends StatelessWidget {
  const ExchangeRateSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Skeleton(
          height: 50,
        ),
      ],
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({
    super.key,
    this.height,
    this.width,
    this.borderRadius = 16,
    this.tint = Colors.black,
  });

  final double? height, width, borderRadius;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(16.0 / 2),
      decoration: BoxDecoration(
        color: tint!.withOpacity(0.04),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
      ),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({super.key, this.size = 24});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: AppColors.appPrimaryColor.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}

class ListSkeleton extends StatelessWidget {
  const ListSkeleton({super.key, this.numOfList = 2});
  final int numOfList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(numOfList, (_) => listItemSkeleton(context)),
    );
  }

  Widget listItemSkeleton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Skeleton(
            width: double.infinity,
            height: 20,
          ),
          const YBox(
            20,
          ),
          Skeleton(
            width: context.getHeight(.4),
            height: 20,
          ),
        ],
      ),
    );
  }
}
