import 'package:flutter/material.dart';
import 'package:urps_ordein/models/menu_model.dart';

class SideMenuData {
  static final menu = <MenuModel>[
    MenuModel(
      icon: Icons.dashboard_rounded,
      title: 'Dashboard',
      route: '/',
      children: [],
    ),
    MenuModel(
      icon: Icons.business,
      title: 'Business',
      route: '/businesses',
      children: [
        MenuModel(
          icon: Icons.list_alt_rounded,
          title: 'List',
          route: '/businesses',
          children: [],
        ),
        MenuModel(
          icon: Icons.group_outlined,
          title: 'Users',
          route: '/businesses/users',
          children: [],
        ),
        MenuModel(
          icon: Icons.person_outline,
          title: 'Details',
          route: '/businesses/users/details',
          children: [],
        ),
      ],
    ),
  ];
}
