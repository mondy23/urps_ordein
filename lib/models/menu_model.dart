import 'package:flutter/widgets.dart';

class MenuModel {
  final IconData icon;
  final String title;
  String route;
  final List children;

  MenuModel({required this.icon, required this.title, required this.route, required this.children});
}
