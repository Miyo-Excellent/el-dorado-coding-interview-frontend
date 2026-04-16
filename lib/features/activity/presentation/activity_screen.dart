import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/widgets.dart';

/// Activity screen.
///
/// Fully stateless — all state managed by [FilterPillsBar].
/// Layout delegated entirely to the shared atomic widget library.
class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  static const _filters = ['Todo', 'Cambios', 'Retiros', 'Recargas'];

  // ── Static feed data ─────────────────────────────────────────────────────
  static const _feed = [
    ActivityGroupData(
      dateLabel: 'Hoy',
      items: [
        ActivityItem(
          icon: Icons.swap_horiz,
          title: 'Cambio USDT a COP',
          time: '14:30',
          status: 'Completado',
          statusColor: AppColors.primary,
          amount: '-50.00 USDT',
          amountColor: AppColors.primary,
          secondaryAmount: '+195,000 COP',
        ),
        ActivityItem(
          icon: Icons.arrow_downward,
          title: 'Recarga USDT',
          time: '10:15',
          status: 'Pendiente',
          statusColor: AppColors.primaryContainer,
          amount: '+100.00 USDT',
          amountColor: AppColors.primary,
        ),
      ],
    ),
    ActivityGroupData(
      dateLabel: 'Ayer',
      items: [
        ActivityItem(
          icon: Icons.arrow_upward,
          title: 'Retiro a Banco',
          time: '18:45',
          status: 'Completado',
          statusColor: AppColors.primary,
          amount: '-500,000 COP',
          amountColor: AppColors.secondary,
        ),
        ActivityItem(
          icon: Icons.swap_horiz,
          title: 'Cambio USDC a VES',
          time: '09:20',
          status: 'Cancelado',
          statusColor: AppColors.error,
          amount: '-20.00 USDC',
          amountColor: AppColors.secondary,
          strikethrough: true,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          // ── ATOM: Ambient Glow ───────────────────────────────────────
          const AmbientGlowBackground(),

          CustomScrollView(
            slivers: [
              // ── ORGANISM: Activity App Bar ───────────────────────────
              ElDoradoSliverAppBar(
                variant: ElDoradoAppBarVariant.page,
                title: 'ACTIVIDAD',
                titleColor: AppColors.primary,
                titleLetterSpacing: 2,
                centerTitle: true,
                leadingIcon: Icons.menu,
                backgroundOpacity: 0.8,
              ),

              // ── MOLECULE: Filter Pills Bar ───────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.lg),
                  child: FilterPillsBar(
                    filters: _filters,
                    onFilterChanged: (_) {},
                  ),
                ),
              ),

              // ── ORGANISM: Activity Feed ──────────────────────────────
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xl,
                ),
                sliver: SliverToBoxAdapter(
                  child: ActivityFeed(groups: _feed),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
