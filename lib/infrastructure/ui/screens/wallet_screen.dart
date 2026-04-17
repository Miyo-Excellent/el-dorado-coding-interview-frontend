import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/widgets.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/wallet/wallet_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/wallet/wallet_state.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/activity/activity_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/activity/activity_state.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/screens/wallet/wallet_deposit_sheet.dart';
import 'package:go_router/go_router.dart';

/// Wallet screen.
///
/// **MVVM pattern:**
/// - **Model** → [WalletAsset]
/// - **ViewModel** → [WalletCubit]
/// - **View** → this widget
///
/// Uses [BlocBuilder] for reactive UI and the existing atomic widget library.
class WalletScreen extends StatefulWidget {
  final bool openDeposit;

  const WalletScreen({super.key, this.openDeposit = false});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.openDeposit) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const WalletDepositSheet(),
        );
      });
    }
  }

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
                onRefresh: () async {
                  context.read<WalletCubit>().refresh();
                  context.read<ActivityCubit>().refresh();
                },
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
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => const WalletDepositSheet(),
                                );
                              },
                            ),
                            QuickAction(
                              icon: Icons.arrow_upward,
                              label: 'Retirar',
                              onTap: () {
                                context.go('/');
                              },
                            ),
                            QuickAction(
                              icon: Icons.swap_horiz,
                              label: 'Cambiar',
                              onTap: () {
                                context.go('/');
                              },
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
                                  iconUrl: a.iconUrl,
                                  name: a.name,
                                  subtitle: a.subtitle,
                                  amount: a.amount,
                                  usdValue: 'US\$${a.usdValue}',
                                ),
                              )
                              .toList(),
                          onSeeAll: () {},
                        ),
                        const SizedBox(height: AppSpacing.xxxl + 8),

                        // ── ORGANISM: Recent Activity List ──────────────
                        BlocBuilder<ActivityCubit, ActivityState>(
                          builder: (context, activityState) {
                            if (activityState.groups.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            // Aplanar la lista de grupos para tomar los primeros 3 items
                            final recentItems = activityState.groups
                                .expand((g) => g.items)
                                .take(3)
                                .toList();

                            return RecentActivityList(
                              onSeeAll: () {
                                context.go('/activity'); // Navegar a la pestaña Activity
                              },
                              transactions: recentItems.map((item) {
                                return RecentTransaction(
                                  icon: item.amountColor == 1 ? Icons.download : Icons.upload,
                                  iconBgColor: item.amountColor == 1
                                      ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.10)
                                      : Theme.of(context).colorScheme.error.withValues(alpha: 0.10),
                                  iconColor: item.amountColor == 1
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.error,
                                  title: item.title,
                                  subtitle: item.time,
                                  amount: item.amount,
                                  amountColor: item.amountColor == 1
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onSurface,
                                  onTap: () {},
                                );
                              }).toList(),
                            );
                          },
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
