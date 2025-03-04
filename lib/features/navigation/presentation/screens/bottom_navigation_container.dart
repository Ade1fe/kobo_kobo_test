import 'package:flutter/material.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class BottomNavigationContainer extends StatefulWidget {
  const BottomNavigationContainer({
    super.key,
    required this.selectedTab,
    required this.hideNav,
  });

  final AfrTab selectedTab;
  final bool hideNav;

  @override
  State<BottomNavigationContainer> createState() {
    return _BottomNavigationContainerState();
  }
}

class _BottomNavigationContainerState extends State<BottomNavigationContainer>
    with ChangeNotifier {
  late bool _hideNav;

  @override
  void initState() {
    super.initState();
    _hideNav = widget.hideNav;
  }

  @override
  Widget build(BuildContext context) {
    _hideNav = widget.hideNav;

    return _hideNav
        ? const SizedBox.shrink()
        : BottomAppBar(
            color: const Color(0xFFA6AAB4),
            selectedColor: AppColors.appPrimaryColor,
            backgroundColor: AppColors.white,
            selectedTab: widget.selectedTab,
            height: 80,
            onTabSelected: (tab) async {
              AppNavigator.of(context).push(AppRoutes.tab(tab));
            },
            items: [
              BottomAppBarItem(
                icon: LocalSvgImage(homeInActive),
                activeIcon: LocalSvgImage(homeActive),
                title: 'Home',
                tab: AfrTab.home,
              ),
              BottomAppBarItem(
                icon: LocalSvgImage(cardInactive),
                activeIcon: LocalSvgImage(cardActive),
                title: 'Cards',
                tab: AfrTab.cards,
              ),
              BottomAppBarItem(
                icon: LocalSvgImage(loansInactive),
                activeIcon: LocalSvgImage(loansActive),
                title: 'Loans',
                tab: AfrTab.loans,
              ),
              BottomAppBarItem(
                icon: LocalSvgImage(moreInactive),
                activeIcon: LocalSvgImage(moreActive),
                title: 'More',
                tab: AfrTab.more,
              ),
            ],
          );
  }
}

class BottomAppBarItem {
  BottomAppBarItem({
    required this.icon,
    required this.activeIcon,
    required this.title,
    required this.tab,
  });
  Widget icon;
  Widget activeIcon;
  String title;
  AfrTab tab;
}

class BottomAppBar extends StatefulWidget {
  const BottomAppBar({
    super.key,
    required this.items,
    this.height = Insets.dim_66,
    required this.backgroundColor,
    required this.color,
    required this.selectedColor,
    required this.selectedTab,
    required this.onTabSelected,
  }) : assert(
          items.length >= 2 || items.length <= 5,
          'List of bottom nav must be 2-5',
        );

  final List<BottomAppBarItem> items;
  final double height;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final AfrTab selectedTab;
  final Function(AfrTab) onTabSelected;

  @override
  State<StatefulWidget> createState() => BottomAppBarState();
}

class BottomAppBarState extends State<BottomAppBar> {
  @override
  Widget build(BuildContext context) {
    final items = widget.items.map((tabItem) {
      return _buildTabItem(
        item: tabItem,
        onPressed: () => widget.onTabSelected(tabItem.tab),
      );
    }).toList();

    items.insert(items.length >> 1, _buildMiddleTabItem());

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.3,
            color: AppColors.appPrimaryColor.withOpacity(0.7),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return SizedBox(
      height: widget.height,
      child: const SizedBox(height: Insets.dim_30),
    );
  }

  Widget _buildTabItem({
    required BottomAppBarItem item,
    required Function()? onPressed,
  }) {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        width: Insets.dim_30,
        child: Material(
          type: MaterialType.transparency,
          elevation: 4,
          child: InkWell(
            onTap: onPressed,
            child: Column(
              children: [
                const Spacer(),
                if (widget.selectedTab == item.tab)
                  item.activeIcon
                else
                  item.icon,
                const YBox(Insets.dim_4),
                Text(
                  item.title,
                  style: context.textTheme.bodySmall!.copyWith(
                    color: widget.selectedTab == item.tab
                        ? AppColors.appPrimaryColor
                        : AppColors.black.withOpacity(0.45),
                  ),
                ),
                const YBox(kBottomNavigationBarHeight - 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
