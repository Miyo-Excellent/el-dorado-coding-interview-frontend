import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_router.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/widgets.dart';

/// Persistent shell that wraps all tab-level screens.
///
/// Provides the [ElDoradoNavBar] organism and routes between tabs using
/// [GoRouter.go] so the shell is never rebuilt on tab switch.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  static const List<_TabRoute> _tabs = [
    _TabRoute(AppRoutes.home),
    _TabRoute(AppRoutes.wallet),
    _TabRoute(AppRoutes.activity),
    _TabRoute(AppRoutes.settings),
  ];

  // Maps matching the ElDoradoNavBar items list (same order as _tabs).
  static const List<ElDoradoNavItem> _navItems = [
    ElDoradoNavItem(
      icon: Icons.swap_horizontal_circle_outlined,
      selectedIcon: Icons.swap_horizontal_circle,
      label: 'Exchange',
    ),
    ElDoradoNavItem(
      icon: Icons.account_balance_wallet_outlined,
      selectedIcon: Icons.account_balance_wallet,
      label: 'Wallet',
    ),
    ElDoradoNavItem(
      icon: Icons.history_outlined,
      selectedIcon: Icons.history,
      label: 'Activity',
    ),
    ElDoradoNavItem(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      label: 'Settings',
    ),
  ];

  int _locationToIndex(String location) {
    if (location.startsWith(AppRoutes.wallet)) return 1;
    if (location.startsWith(AppRoutes.activity)) return 2;
    if (location.startsWith(AppRoutes.settings)) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToIndex(location);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: child,
      // ── ORGANISM: Electric Alchemist Navigation Bar ───────────────────
      bottomNavigationBar: ElDoradoNavBar(
        currentIndex: currentIndex,
        items: _navItems,
        onTap: (i) => context.go(_tabs[i].route),
      ),
    );
  }
}

/// Internal route record — keeps route string co-located with tab index.
class _TabRoute {
  const _TabRoute(this.route);
  final String route;
}
