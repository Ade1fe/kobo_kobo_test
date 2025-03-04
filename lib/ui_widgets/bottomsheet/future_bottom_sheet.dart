import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

import 'package:flutter/material.dart';

class FutureListBottomSheet<T> extends StatelessWidget
    with BaseBottomSheetMixin {
  const FutureListBottomSheet({
    required this.future,
    required this.itemBuilder,
    this.onItemSelected,
    this.height,
    this.desc,
    this.title,
    this.searchWidget,
    this.isDismissible = true,
    this.centerTitle = false,
    this.showLeading = true,
    super.key,
  });

  final Future<List<T>> Function() future;
  final Function(T)? onItemSelected;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget? searchWidget;
  final double? height;
  final String? title, desc;
  final bool isDismissible;
  final bool centerTitle;
  final bool showLeading;

  @override
  Widget build(BuildContext context) {
    final child = FutureBuilder<List<T>>(
      future: future(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              if (searchWidget != null) ...[
                searchWidget!,
                const YBox(Insets.dim_18),
              ],
              ListView.builder(
                physics: const PageScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      if (onItemSelected != null) {
                        onItemSelected!(item);
                      } else {
                        // AfrNavigator.of(context).popDialog(item);
                        Navigator.of(context).pop(item);
                      }
                    },
                    child: itemBuilder(context, item),
                  );
                },
              ),
            ],
          );
        }
        if (snapshot.hasError) {
          return const AppErrorWidget();
        }
        return const AppLoadingWidget();
      },
    );

    return BaseBottomSheet(
      height: height,
      title: title,
      desc: desc,
      centerTitle: centerTitle,
      showLeading: showLeading,
      isDismissible: isDismissible,
      child: child,
    );
  }
}
