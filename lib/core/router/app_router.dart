import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/wallet/presentation/wallet_screen.dart';
import '../../features/activity/presentation/activity_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../shell/app_shell.dart';

/// Named routes for the application.
abstract final class AppRoutes {
  static const String home = '/';
  static const String wallet = '/wallet';
  static const String activity = '/activity';
  static const String settings = '/settings';
}

/// The application router powered by go_router.
///
/// Uses a [ShellRoute] with [AppShell] to keep the [NavigationBar]
/// persistent across the four main tab destinations.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  debugLogDiagnostics: true,
  routes: [
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return AppShell(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.wallet,
          name: 'wallet',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: WalletScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.activity,
          name: 'activity',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ActivityScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.settings,
          name: 'settings',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SettingsScreen(),
          ),
        ),
      ],
    ),
  ],
);
