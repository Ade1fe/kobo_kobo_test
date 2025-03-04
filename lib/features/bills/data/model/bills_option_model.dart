import 'package:flutter/material.dart';

class BillsOptionModel {
  final String name;
  final String icon;
  final String route;
  final Color? color;

  BillsOptionModel({
    required this.name,
    required this.icon,
    required this.route,
    this.color,
  });
}
