import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/widgets.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/blocs/exchange/exchange_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/blocs/exchange/exchange_event.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/blocs/exchange/exchange_state.dart';

/// Home / Exchange screen.
///
/// **MVVM pattern:**
/// - **Model** → [OfferModel] + [RecommendationResponse]
/// - **ViewModel** → [ExchangeBloc] (BLoC/events/states)
/// - **View** → this widget
///
/// Uses [BlocBuilder] for reactive UI updates and [StatefulWidget] for
/// local UI state (text controllers, input focus).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _amountController = TextEditingController(text: '50');

  @override
  void initState() {
    super.initState();
    // Trigger initial API fetch
    context.read<ExchangeBloc>().add(const FetchRecommendations());
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  /// Available fiat currencies for the exchange.
  static const _fiatCurrencies = ['COP', 'BRL', 'PEN', 'USD'];

  /// Map currency code → display symbol
  static const _currencySymbols = {
    'COP': '\$',
    'BRL': 'R\$',
    'PEN': 'S/',
    'USD': '\$',
  };

  /// Map currency code → color
  static const _currencyColors = {
    'COP': Color(0xFFFFD100),
    'BRL': Color(0xFF009739),
    'PEN': Color(0xFFD91023),
    'USD': Color(0xFF85BB65),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<ExchangeBloc, ExchangeState>(
        builder: (context, state) {
          return Stack(
            children: [
              // ── ATOM: Ambient Glow (consistent across all screens) ──
              const AmbientGlowBackground(),

              CustomScrollView(
                slivers: [
                  // ── ORGANISM: Branded App Bar ─────────────────────────
                  const ElDoradoSliverAppBar(
                    variant: ElDoradoAppBarVariant.branded,
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.xl,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // ── ORGANISM: Exchange Card ─────────────────────
                        ExchangeCard(
                          fromAmount: state.type == 0
                              ? state.amount
                              : state.formattedConvertedAmount,
                          fromCurrency: state.type == 0
                              ? 'USDT'
                              : state.fiatCurrencyId,
                          fromColor: state.type == 0
                              ? const Color(0xFF26A17B)
                              : _currencyColors[state.fiatCurrencyId] ??
                                    const Color(0xFFFFD100),
                          fromSymbol: state.type == 0
                              ? '₮'
                              : (_currencySymbols[state.fiatCurrencyId] ??
                                    '\$'),
                          toAmount: state.type == 0
                              ? state.formattedConvertedAmount
                              : state.amount,
                          toCurrency: state.type == 0
                              ? state.fiatCurrencyId
                              : 'USDT',
                          toColor: state.type == 0
                              ? _currencyColors[state.fiatCurrencyId] ??
                                    const Color(0xFFFFD100)
                              : const Color(0xFF26A17B),
                          toSymbol: state.type == 0
                              ? (_currencySymbols[state.fiatCurrencyId] ?? '\$')
                              : '₮',
                          limitsText: state.limitsText,
                          onSwap: () {
                            context.read<ExchangeBloc>().add(
                              const DirectionToggled(),
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.xl),

                        // ── Currency Selector (StatefulWidget local state)
                        _CurrencySelector(
                          currencies: _fiatCurrencies,
                          selectedCurrency: state.fiatCurrencyId,
                          onChanged: (currency) {
                            context.read<ExchangeBloc>().add(
                              FiatCurrencyChanged(currency),
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.xxl),

                        // ── MOLECULE: Section Header ────────────────────
                        const SectionHeader(
                          label: 'MERCADO',
                          title: 'Mejores Ofertas',
                        ),
                        const SizedBox(height: AppSpacing.lg),

                        // ── MOLECULE: Offer Tab Bar ─────────────────────
                        OfferTabBar(
                          tabs: const ['💸 Mejor Precio', '⭐ Mejor Reputación'],
                          onTabChanged: (idx) {
                            context.read<ExchangeBloc>().add(
                              OfferTabChanged(idx),
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // ── Content based on status ─────────────────────
                        _buildOfferContent(context, state),
                        const SizedBox(height: AppSpacing.xxl),

                        // ── ATOM: Primary CTA ───────────────────────────
                        PrimaryButton(
                          label: 'Cambiar a ${state.fiatCurrencyId}',
                          onPressed: state.status == ExchangeStatus.loaded
                              ? () {}
                              : null,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                      ]),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOfferContent(BuildContext context, ExchangeState state) {
    switch (state.status) {
      case ExchangeStatus.initial:
      case ExchangeStatus.loading:
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.xxl),
            child: CircularProgressIndicator(),
          ),
        );

      case ExchangeStatus.error:
        return _ErrorCard(message: state.errorMessage);

      case ExchangeStatus.empty:
        return const _EmptyCard();

      case ExchangeStatus.loaded:
        final offer = state.activeOffer;
        if (offer == null) return const _EmptyCard();

        final stats = offer.offerMakerStats;
        final paymentNames = offer.paymentMethods
            .map(_formatPaymentMethod)
            .toList();

        return OfferCard(
          sellerInitials: offer.username.isNotEmpty
              ? offer.username[0].toUpperCase()
              : '?',
          sellerUsername: offer.username,
          sellerRating: stats?.rating.toString() ?? 'N/A',
          sellerTier: stats?.tierLabel ?? 'Base Tier',
          paymentMethods: paymentNames,
          rate: '${offer.formattedRate} ${offer.fiatCurrencyId}',
          time: stats?.orderTimeDisplay ?? '~? min',
          successRate: stats?.successRatePercent ?? 'N/A',
          isSellerOnline: offer.isOnline,
          isSellerVerified: (stats?.tierNameCode ?? 'NO_TIER') != 'NO_TIER',
          onTap: () {},
        );
    }
  }

  /// Format raw payment method IDs to readable names.
  String _formatPaymentMethod(String raw) {
    return raw
        .replaceFirst('app_', '')
        .replaceFirst('bank_', '')
        .split('_')
        .map(
          (w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '',
        )
        .join(' ');
  }
}

/// Local stateful widget for selecting fiat currency.
/// Uses StatefulWidget for local UI state (expansion, animation).
class _CurrencySelector extends StatelessWidget {
  final List<String> currencies;
  final String selectedCurrency;
  final ValueChanged<String> onChanged;

  const _CurrencySelector({
    required this.currencies,
    required this.selectedCurrency,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      children: currencies.map((currency) {
        final isSelected = currency == selectedCurrency;
        return ChoiceChip(
          label: Text(currency),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) onChanged(currency);
          },
        );
      }).toList(),
    );
  }
}

/// Error state card.
class _ErrorCard extends StatelessWidget {
  final String message;
  const _ErrorCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.errorContainer.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
            size: 48,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Error al obtener ofertas',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            message,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Empty state card — no offers available.
class _EmptyCard extends StatelessWidget {
  const _EmptyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        children: [
          Icon(
            Icons.inbox_outlined,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            size: 48,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Sin ofertas disponibles',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'No hay liquidez para este par de moneda. Prueba con otro monto o divisa.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
