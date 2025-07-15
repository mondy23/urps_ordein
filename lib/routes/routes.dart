import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urps_ordein/pages/specific_user.dart';
import 'package:urps_ordein/pages/dashboard/dashboard.dart';
import 'package:urps_ordein/pages/main_page.dart';
import 'package:urps_ordein/pages/businesses/business.dart';
import 'package:urps_ordein/pages/users.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      pageBuilder: (context, state, child) {
        return _buildFadeTransitionPage(
          MainPage(child: child),
          key: state.pageKey,
        );
      },
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) =>
              _buildFadeTransitionPage(const Dashboard(), key: state.pageKey),
        ),
        GoRoute(
          path: '/businesses',
          pageBuilder: (context, state) =>
              _buildFadeTransitionPage(const Business(), key: state.pageKey),
          routes: [
            GoRoute(
              path: 'users', // -> /businesses/users
              pageBuilder: (context, state) =>
                  _buildFadeTransitionPage(const Users(), key: state.pageKey),
              routes: [
                GoRoute(
                  path: 'details', // -> /businesses/users/details
                  pageBuilder: (context, state) =>
                      _buildFadeTransitionPage(const SpecificUser(),
                          key: state.pageKey),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);


// 🔄 Fade transition helper
CustomTransitionPage _buildFadeTransitionPage(
  Widget child, {
  required LocalKey key,
}) {
  return CustomTransitionPage(
    key: key,
    transitionDuration: const Duration(milliseconds: 200),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final zoom = Tween<double>(
        begin: 0.98,
        end: 1.0,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: zoom, child: child),
      );
    },
  );
}
