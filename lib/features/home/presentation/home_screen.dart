import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/widgets.dart';

/// Home / Exchange screen.
///
/// All layout is delegated to the shared atomic widget library.
/// The screen body is a single `CustomScrollView` with three slivers.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        slivers: [
          // ── ORGANISM: Branded App Bar ──────────────────────────────────
          const ElDoradoSliverAppBar(variant: ElDoradoAppBarVariant.branded),

          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.xl,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── ORGANISM: Exchange Card ──────────────────────────────
                ExchangeCard(
                  fromAmount: '50.00',
                  fromCurrency: 'USDT',
                  fromColor: const Color(0xFF26A17B),
                  fromSymbol: '₮',
                  toAmount: '180,400.00',
                  toCurrency: 'COP',
                  toColor: const Color(0xFFFFD100),
                  toSymbol: '\$',
                  limitsText: 'Límites: 1.50 – 495.00 USDT',
                  onSwap: () {},
                ),
                const SizedBox(height: AppSpacing.xxl),

                // ── MOLECULE: Section Header ─────────────────────────────
                const SectionHeader(label: 'MERCADO', title: 'Mejores Ofertas'),
                const SizedBox(height: AppSpacing.lg),

                // ── MOLECULE: Offer Tab Bar ──────────────────────────────
                OfferTabBar(
                  tabs: const ['💸 Mejor Precio', '⭐ Mejor Reputación'],
                  onTabChanged: (_) {},
                ),
                const SizedBox(height: AppSpacing.md),

                // ── ORGANISM: Offer Card ─────────────────────────────────
                OfferCard(
                  sellerInitials: 'G',
                  sellerUsername: 'glo_cop_usdt',
                  sellerRating: '5.0',
                  sellerTier: 'Silver Tier',
                  paymentMethods: const ['Nequi', 'Bancolombia', 'Plin'],
                  rate: '3,608 COP',
                  time: '~4 min',
                  successRate: '98%',
                  isSellerOnline: true,
                  isSellerVerified: true,
                  onTap: () {},
                ),
                const SizedBox(height: AppSpacing.xxl),

                // ── ATOM: Primary CTA ────────────────────────────────────
                PrimaryButton(label: 'Cambiar a COP', onPressed: () {}),
                const SizedBox(height: AppSpacing.lg),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
