import 'package:flutter/material.dart';
import 'package:kobo_kobo/core/data/core_data.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/functional_util/assets.dart';

class DashboardVm extends ChangeNotifier {
  int currentValue = 0;
  double innerScrollPosition = 0;
  final welcomePageController = PageController();

  void changeCurrentValue(int value) {
    currentValue = value;
    innerScrollPosition = value.toDouble();
    notifyListeners();
  }

  List<ItemClass> items(BuildContext context) => [
        ItemClass(
          title: 'Transfer',
          img: transferPng,
          onTap: () => AppNavigator.of(context).push(AppRoutes.transfer),
        ),
        ItemClass(
          title: 'Bills',
          img: billsPng,
          onTap: () => AppNavigator.of(context).push(AppRoutes.bills),
        ),
        ItemClass(
          title: 'Top Up',
          img: topUpPng,
          onTap: () => AppNavigator.of(context).push(AppRoutes.topUp),
        ),
        ItemClass(
            title: 'Savings',
            img: savingsPng,
            onTap: () => AppNavigator.of(context).push(AppRoutes.savings)),
      ];
}
