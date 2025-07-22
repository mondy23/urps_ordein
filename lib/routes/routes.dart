import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urps_ordein/features/users/specific_user.dart';
import 'package:urps_ordein/features/dashboard/dashboard.dart';
import 'package:urps_ordein/layout/main_page.dart';
import 'package:urps_ordein/features/business/business.dart';
import 'package:urps_ordein/features/users/users.dart';

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
              path: ':id/users',
              pageBuilder: (context, state) {
                final idParam = state.pathParameters['id'];
                final id = int.tryParse(idParam ?? '');

                if (id == null) {
                  return _buildFadeTransitionPage(
                    const Scaffold(
                      body: Center(child: Text('Invalid business ID')),
                    ),
                    key: state.pageKey,
                  );
                }

                return _buildFadeTransitionPage(
                  Users(businessID: id),
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: ':id/details',
                  pageBuilder: (context, state) {
                    final idParam = state.pathParameters['id'];
                    final id = int.tryParse(idParam ?? '');
                    if (id == null) {
                      return _buildFadeTransitionPage(
                        const Scaffold(
                          body: Center(child: Text('Invalid business ID')),
                        ),
                        key: state.pageKey,
                      );
                    }

                    return _buildFadeTransitionPage(
                      SpecificUser(userID: id),
                      key: state.pageKey,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

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
