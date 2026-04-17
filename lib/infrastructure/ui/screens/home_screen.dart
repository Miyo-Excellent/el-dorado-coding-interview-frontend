import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/widgets.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/home/home_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/home/home_state.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/currency/currency_cubit.dart';

/// Home / Exchange screen.
///
/// **MVVM pattern:**
/// - **Model** → [OfferModel] + [RecommendationResponse]
/// - **ViewModel** → [HomeCubit] (Cubit/states)
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
  final _tengoController = TextEditingController();
  final _quieroController = TextEditingController();
  final _tengoFocus = FocusNode();
  final _quieroFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with default state values
    final cubit = context.read<HomeCubit>();
    _tengoController.text = cubit.state.amount;
    _quieroController.text = cubit.state.formattedConvertedAmount;
    
    // Trigger initial API fetch
    cubit.fetchRecommendations();
  }

  @override
  void dispose() {
    _tengoFocus.dispose();
    _quieroFocus.dispose();
    _tengoController.dispose();
    _quieroController.dispose();
    super.dispose();
  }

  void _showNumericKeypad(BuildContext context, TextEditingController controller, FocusNode focusNode, bool isTengo) {
    focusNode.requestFocus();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black26,
      builder: (BuildContext ctx) {
        return NumericKeypad(
          onKeyPress: (val) {
            final t = controller.text;
            if (val == '.' && t.contains('.')) return;
            if (t.length > 15) return;
            
            final newText = t + val;
            controller.text = newText;
            controller.selection = TextSelection.fromPosition(TextPosition(offset: newText.length));

            if (isTengo) {
              context.read<HomeCubit>().changeAmount(newText);
            } else {
              context.read<HomeCubit>().changeConvertedAmount(newText);
            }
          },
          onDelete: () {
            final t = controller.text;
            if (t.isEmpty) return;
            
            final newText = t.substring(0, t.length - 1);
            controller.text = newText;
            controller.selection = TextSelection.fromPosition(TextPosition(offset: newText.length));

            if (newText.isEmpty) {
              if (isTengo) {
                context.read<HomeCubit>().changeAmount('');
              } else {
                context.read<HomeCubit>().changeConvertedAmount('');
              }
              return;
            }

            if (isTengo) {
              context.read<HomeCubit>().changeAmount(newText);
            } else {
              context.read<HomeCubit>().changeConvertedAmount(newText);
            }
          },
          onDone: () {
            focusNode.unfocus();
            Navigator.of(ctx).pop();
          },
        );
      },
    ).whenComplete(() {
      focusNode.unfocus();
    });
  }

  // Hardcoded lists removed.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // Sync controllers with state without triggering onChanged loops,
          // and respect user typing by not overwriting focused text fields.
          if (!_tengoFocus.hasFocus && _tengoController.text != state.amount) {
            _tengoController.text = state.amount;
          }
          if (!_quieroFocus.hasFocus && _quieroController.text != state.formattedConvertedAmount) {
            _quieroController.text = state.formattedConvertedAmount;
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // ── ATOM: Ambient Glow (consistent across all screens) ──
              const AmbientGlowBackground(),

              RefreshIndicator(
                onRefresh: () => context.read<HomeCubit>().fetchRecommendations(),
                color: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: CustomScrollView(
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
                        ExchangeCard(
                          fromAmount: state.amount,
                          fromCurrency: state.type == 0
                              ? state.cryptoCurrency.symbol
                              : state.fiatCurrency.symbol,
                          fromColor: const Color(0xFF26A17B),
                          fromSymbol: state.type == 0
                              ? state.cryptoCurrency.symbolShort
                              : state.fiatCurrency.symbolShort,
                          fromIconUrl: state.type == 0
                              ? state.cryptoCurrency.iconUrl
                              : state.fiatCurrency.iconUrl,
                          toAmount: state.formattedConvertedAmount,
                          toCurrency: state.type == 0
                              ? state.fiatCurrency.symbol
                              : state.cryptoCurrency.symbol,
                          toColor: const Color(0xFFFFD100),
                          toSymbol: state.type == 0
                              ? state.fiatCurrency.symbolShort
                              : state.cryptoCurrency.symbolShort,
                          toIconUrl: state.type == 0
                              ? state.fiatCurrency.iconUrl
                              : state.cryptoCurrency.iconUrl,
                          limitsText: state.limitsText,
                          fromAmountController: _tengoController,
                          toAmountController: _quieroController,
                          fromFocusNode: _tengoFocus,
                          toFocusNode: _quieroFocus,
                          onFromAmountChanged: (val) {
                            if (val.isNotEmpty) {
                              context.read<HomeCubit>().changeAmount(val);
                            }
                          },
                          onToAmountChanged: (val) {
                            if (val.isNotEmpty) {
                              context.read<HomeCubit>().changeConvertedAmount(val);
                            }
                          },
                          onFromCurrencyTap: () => _showCurrencyPicker(context, isTengo: true),
                          onToCurrencyTap: () => _showCurrencyPicker(context, isTengo: false),
                          onSwap: () {
                            context.read<HomeCubit>().toggleDirection();
                          },
                          onFromInputTap: () => _showNumericKeypad(
                            context,
                            _tengoController,
                            _tengoFocus,
                            true,
                          ),
                          onToInputTap: () => _showNumericKeypad(
                            context,
                            _quieroController,
                            _quieroFocus,
                            false,
                          ),
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
                            context.read<HomeCubit>().changeOfferTab(idx);
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // ── Content based on status ─────────────────────
                        _buildOfferContent(context, state),
                        const SizedBox(height: AppSpacing.xxl),

                        // ── ATOM: Primary CTA ───────────────────────────
                        PrimaryButton(
                          label: 'Cambiar a ${state.fiatCurrency.symbol}',
                          onPressed: state.status == HomeStatus.loaded
                              ? () {}
                              : null,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      ),
    );
  }

  Widget _buildOfferContent(BuildContext context, HomeState state) {
    switch (state.status) {
      case HomeStatus.initial:
      case HomeStatus.loading:
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.xxl),
            child: CircularProgressIndicator(),
          ),
        );

      case HomeStatus.error:
        return _ErrorCard(message: state.errorMessage);

      case HomeStatus.empty:
        return const _EmptyCard();

      case HomeStatus.loaded:
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
          isSellerVerified: (stats?.mmScore?.tier.nameCode ?? 'NO_TIER') != 'NO_TIER',
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

  void _showCurrencyPicker(BuildContext context, {required bool isTengo}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.8,
          builder: (_, scrollController) {
            return Container(
              padding: const EdgeInsets.only(top: AppSpacing.xl, left: AppSpacing.xl, right: AppSpacing.xl),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
              ),
              child: BlocBuilder<CurrencyCubit, CurrencyState>(
                builder: (context, currencyState) {
                  if (currencyState is CurrencyLoading || currencyState is CurrencyInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (currencyState is CurrencyError) {
                    return Center(child: Text('Error cargando monedas', style: TextStyle(color: Theme.of(context).colorScheme.error)));
                  }

                  if (currencyState is CurrencyLoaded) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Seleccionar Moneda',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Expanded(
                          child: ListView(
                            controller: scrollController,
                            children: [
                              // Category: CRYPTO
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                                child: Text(
                                  'CRYPTO',
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                              ...currencyState.cryptoCurrencies.map((currency) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: const Color(0xFF26A17B),
                                    backgroundImage: currency.iconUrl.isNotEmpty ? NetworkImage(currency.iconUrl) : null,
                                    radius: 12,
                                    child: currency.iconUrl.isEmpty ? Text(
                                      currency.symbolShort,
                                      style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                                    ) : null,
                                  ),
                                  title: Text(currency.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                                  subtitle: Text(currency.symbol),
                                  onTap: () {
                                    context.read<HomeCubit>().selectCurrency(currency, isTengo: isTengo);
                                    Navigator.pop(ctx);
                                  },
                                );
                              }),
                              const SizedBox(height: AppSpacing.md),
                              // Category: FIAT
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                                child: Text(
                                  'FIAT',
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                              ...currencyState.fiatCurrencies.map((currency) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: const Color(0xFFFFD100),
                                    backgroundImage: currency.iconUrl.isNotEmpty ? NetworkImage(currency.iconUrl) : null,
                                    radius: 12,
                                    child: currency.iconUrl.isEmpty ? Text(
                                      currency.symbolShort,
                                      style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                                    ) : null,
                                  ),
                                  title: Text(currency.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                                  subtitle: Text(currency.symbol),
                                  onTap: () {
                                    context.read<HomeCubit>().selectCurrency(currency, isTengo: isTengo);
                                    Navigator.pop(ctx);
                                  },
                                );
                              }),
                              const SizedBox(height: AppSpacing.xl),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            );
          },
        );
      },
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
