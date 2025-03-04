import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListSklLoader extends StatelessWidget {
  const ListSklLoader({
    super.key,
    required this.loading,
    this.itemBuilder,
    this.scrollDirection = Axis.vertical,
  });
  final bool loading;
  final Axis scrollDirection;
  final Widget Function(BuildContext, int)? itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: loading,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: scrollDirection,
        itemCount: 22,
        itemBuilder: itemBuilder ??
            (context, index) {
              return const Card(
                child: ListTile(
                  title: Text('--'),
                  subtitle: Text('--'),
                  trailing: Icon(Icons.ac_unit),
                ),
              );
            },
      ),
    );
  }
}
