import 'package:flutter/material.dart';

class NavigationModel {
  String title;
  IconData icon;
  void Function() onTap;

  NavigationModel({required this.title, required this.icon, required this.onTap});
}

List<NavigationModel> demoNavigationItems = [
  NavigationModel(title: "Dashboard", icon: Icons.insert_chart, onTap: () {}),
  NavigationModel(title: "Errors", icon: Icons.error, onTap: () {}),
  NavigationModel(title: "Search", icon: Icons.search, onTap: () {}),
  NavigationModel(title: "Notifications", icon: Icons.notifications, onTap: () {}),
  NavigationModel(title: "Settings", icon: Icons.settings, onTap: () {}),
];
