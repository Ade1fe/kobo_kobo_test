import 'package:flutter/material.dart';

enum AfrTab {
  home,
  cards,
  loans,
  more,
}

extension AfrTabUtil on AfrTab {
  static AfrTab? fromString(String? tabName) {
    switch (tabName) {
      case 'home':
        return AfrTab.home;
      case 'cards':
        return AfrTab.cards;
      case 'loans':
        return AfrTab.loans;
      case 'more':
        return AfrTab.more;
      default:
        return AfrTab.home;
    }
  }
}

class AfrTabScreenData {
  AfrTabScreenData({required this.tab, required this.body});

  AfrTab tab;
  Widget body;
}
