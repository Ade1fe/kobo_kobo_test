import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';

class OnboardingVm extends ChangeNotifier {
  int currentValue = 0;
  double innerScrollPosition = 0;
  final welcomePageController = PageController();

  late Timer _timer;

  final onboardingValues = [
    _ValueHolder(
      img: onb1,
      title: 'Send Money with ease',
      desc:
          'With just few clicks you can send money in any denomination with ease',
    ),
    _ValueHolder(
      img: onb2,
      title: '24/7 Support',
      desc:
          'App offers you efficient customer support to assist with whatever issues.',
    ),
  ];

  void changeCurrentValue(int value) {
    currentValue = value;
    innerScrollPosition = value.toDouble();
    notifyListeners();
  }

  void initiate() {
    _timer = Timer.periodic(3.seconds, (_) {
      welcomePageController.animateToPage(
        currentValue != 2 ? currentValue + 1 : 0,
        duration: 200.milliseconds,
        curve: Curves.easeIn,
      );
    });
    notifyListeners();
  }

  void cancelTimer() {
    _timer.cancel();
    welcomePageController.animateToPage(
      currentValue += 2,
      duration: 200.milliseconds,
      curve: Curves.easeIn,
    );
    notifyListeners();
  }

  void navigateToAuth(BuildContext context, String route) {
    AppNavigator.of(context).push(route);
    notifyListeners();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class _ValueHolder {
  _ValueHolder({
    required this.img,
    required this.title,
    required this.desc,
  });
  String title;
  String desc;
  String img;
}
