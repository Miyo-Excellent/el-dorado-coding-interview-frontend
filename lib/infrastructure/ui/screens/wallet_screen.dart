import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/widgets.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/wallet/wallet_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/wallet/wallet_state.dart';

/// Wallet screen.
///
/// **MVVM pattern:**
/// - **Model** → [WalletAsset]
/// - **ViewModel** → [WalletCubit]
/// - **View** → this widget
///
/// Uses [BlocBuilder] for reactive UI and the existing atomic widget library.
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          return Stack(
            children: [
              // ── ATOM: Ambient Glow (consistent across all screens) ──
              const AmbientGlowBackground(),

              RefreshIndicator(
                onRefresh: () => context.read<WalletCubit>().refresh(),
                color: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: CustomScrollView(
                  slivers: [
                  // ── ORGANISM: Wallet App Bar ──────────────────────────
                  const ElDoradoSliverAppBar(
                    variant: ElDoradoAppBarVariant.wallet,
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                      vertical: AppSpacing.xxl,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // ── ORGANISM: Wealth Card ───────────────────────
                        WealthCard(
                          amount: state.formattedBalance,
                          currency: 'USD',
                          trendValue: state.trendText,
                          isPositiveTrend: state.isPositiveTrend,
                        ),
                        const SizedBox(height: AppSpacing.xxxl + 8),

                        // ── ORGANISM: Quick Actions Bar ─────────────────
                        QuickActionsBar(
                          actions: [
                            QuickAction(
                              icon: Icons.add,
                              label: 'Recargar',
                              onTap: () {},
                            ),
                            QuickAction(
                              icon: Icons.arrow_upward,
                              label: 'Retirar',
                              onTap: () {},
                            ),
                            QuickAction(
                              icon: Icons.swap_horiz,
                              label: 'Cambiar',
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xxxl + 8),

                        // ── ORGANISM: Asset List (from Cubit state) ─────
                        AssetList(
                          assets: state.assets
                              .map(
                                (a) => AssetEntry(
                                  icon: Icons.currency_bitcoin,
                                  iconColor: Color(a.iconColor),
                                  name: a.name,
                                  subtitle: a.subtitle,
                                  amount: a.amount,
                                  usdValue: a.usdValue,
                                ),
                              )
                              .toList(),
                          onSeeAll: () {},
                        ),
                        const SizedBox(height: AppSpacing.xxxl + 8),

                        // ── ORGANISM: Recent Activity List ──────────────
                        RecentActivityList(
                          onSeeAll: () {},
                          transactions: [
                            RecentTransaction(
                              icon: Icons.swap_horiz,
                              title: 'Cambio USDT a COP',
                              subtitle: 'Today, 14:30',
                              amount: '-\$50.00',
                              amountColor: Theme.of(
                                context,
                              ).colorScheme.onSurface,
                              onTap: () {},
                            ),
                            RecentTransaction(
                              icon: Icons.download,
                              iconBgColor: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withValues(alpha: 0.10),
                              iconColor: Theme.of(
                                context,
                              ).colorScheme.secondary,
                              title: 'Recarga Nequi',
                              subtitle: 'Yesterday, 09:15',
                              amount: '+\$100.00',
                              amountColor: Theme.of(
                                context,
                              ).colorScheme.secondary,
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                      ]), // SliverChildListDelegate
                    ), // SliverList
                  ), // SliverPadding
                ], // slivers
              ), // CustomScrollView
            ), // RefreshIndicator
          ], // Stack children
        ); // return Stack
      }, // BlocBuilder builder
    ), // BlocBuilder
    ); // Scaffold
  } // build
} // class
