import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/widgets.dart';

/// Wallet screen.
///
/// All layout is delegated to the shared atomic widget library.
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  // ── Static asset data ────────────────────────────────────────────────────
  static const _assets = [
    AssetEntry(
      icon: Icons.currency_bitcoin,
      iconColor: Color(0xFF26A17B),
      name: 'USDT',
      subtitle: 'Tether',
      amount: '840.50',
      usdValue: '≈ \$840.50',
    ),
    AssetEntry(
      icon: Icons.public,
      iconColor: Color(0xFFFFD100),
      name: 'COP',
      subtitle: 'Peso Colombiano',
      amount: '1,440,000',
      usdValue: '≈ \$400.00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        slivers: [
          // ── ORGANISM: Wallet App Bar ───────────────────────────────────
          const ElDoradoSliverAppBar(variant: ElDoradoAppBarVariant.wallet),

          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.xxl,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── ORGANISM: Wealth Card ────────────────────────────────
                const WealthCard(
                  amount: '\$1,240.50',
                  currency: 'USD',
                  trendValue: '+2.4% Today',
                  isPositiveTrend: true,
                ),
                const SizedBox(height: AppSpacing.xxxl + 8),

                // ── ORGANISM: Quick Actions Bar ──────────────────────────
                QuickActionsBar(
                  actions: [
                    QuickAction(icon: Icons.add, label: 'Recargar', onTap: () {}),
                    QuickAction(icon: Icons.arrow_upward, label: 'Retirar', onTap: () {}),
                    QuickAction(icon: Icons.swap_horiz, label: 'Cambiar', onTap: () {}),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxxl + 8),

                // ── ORGANISM: Asset List ─────────────────────────────────
                AssetList(assets: _assets, onSeeAll: () {}),
                const SizedBox(height: AppSpacing.xxxl + 8),

                // ── ORGANISM: Recent Activity List ───────────────────────
                RecentActivityList(
                  onSeeAll: () {},
                  transactions: [
                    RecentTransaction(
                      icon: Icons.swap_horiz,
                      title: 'Cambio USDT a COP',
                      subtitle: 'Today, 14:30',
                      amount: '-\$50.00',
                      amountColor: AppColors.primary,
                      onTap: () {},
                    ),
                    RecentTransaction(
                      icon: Icons.download,
                      iconBgColor:
                          AppColors.primaryContainer.withValues(alpha: 0.10),
                      iconColor: AppColors.primaryContainer,
                      title: 'Recarga Nequi',
                      subtitle: 'Yesterday, 09:15',
                      amount: '+\$100.00',
                      amountColor: AppColors.primaryContainer,
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
