import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/screens/home_screen.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/screens/wallet_screen.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/screens/activity_screen.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/screens/settings_screen.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/screens/p2p/p2p_offer_list_screen.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/screens/p2p/p2p_transaction_screen.dart';
import 'package:el_dorado_coding_interview_frontend/domain/models/offer_model.dart';
import 'app_shell.dart';

/// Named routes for the application.
abstract final class AppRoutes {
  static const String home = '/';
  static const String wallet = '/wallet';
  static const String activity = '/activity';
  static const String settings = '/settings';
  static const String p2pOffers = '/p2p/offers';
  static const String p2pTransaction = '/p2p/transaction';
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
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomeScreen()),
        ),
        GoRoute(
          path: AppRoutes.wallet,
          name: 'wallet',
          pageBuilder: (context, state) {
            final extras = state.extra as Map<String, dynamic>? ?? {};
            return NoTransitionPage(
              child: WalletScreen(openDeposit: extras['openDeposit'] as bool? ?? false),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.activity,
          name: 'activity',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ActivityScreen()),
        ),
        GoRoute(
          path: AppRoutes.settings,
          name: 'settings',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SettingsScreen()),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.p2pOffers,
      name: 'p2pOffers',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>? ?? <String, dynamic>{};
        return P2pOfferListScreen(
          amount: extras['amount'] as String? ?? '0',
          fiatSymbol: extras['fiatSymbol'] as String? ?? 'USD',
          cryptoSymbol: extras['cryptoSymbol'] as String? ?? 'USDT',
          baseRate: extras['baseRate'] as String? ?? '1',
          type: extras['type'] as int? ?? 1,
          apiPaymentMethods: (extras['paymentMethods'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const ['Transferencia', 'Pago Móvil'],
        );
      },
    ),
    GoRoute(
      path: AppRoutes.p2pTransaction,
      name: 'p2pTransaction',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>? ?? <String, dynamic>{};
        return P2pTransactionScreen(
          amount: extras['amount'] as String? ?? '0',
          fiatSymbol: extras['fiatSymbol'] as String? ?? 'USD',
          cryptoSymbol: extras['cryptoSymbol'] as String? ?? 'USDT',
          type: extras['type'] as int? ?? 1,
          offer: extras['offer'] as OfferModel,
        );
      },
    ),
  ],
);
