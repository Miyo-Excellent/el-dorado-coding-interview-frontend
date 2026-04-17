import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/widgets.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/home/home_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/home/home_state.dart';

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

  PersistentBottomSheetController? _keypadController;

  void _showNumericKeypad(BuildContext context, TextEditingController controller, FocusNode focusNode, bool isTengo) {
    if (_keypadController != null) {
      _keypadController!.close();
    }
    
    focusNode.requestFocus();
    
    _keypadController = Scaffold.of(context).showBottomSheet(
      (BuildContext ctx) {
        return NumericKeypad(
          onKeyPress: (val) {
            final t = controller.text;
            if (val == '.' && t.contains('.')) return;
            if (t.length > 20) return;
            
            final currentOffset = controller.selection.baseOffset;
            final offset = currentOffset >= 0 ? currentOffset : t.length;
            
            final prefix = t.substring(0, offset);
            final suffix = t.substring(offset);
            final newText = prefix + val + suffix;
            
            controller.text = newText;
            controller.selection = TextSelection.collapsed(offset: offset + val.length);

            if (isTengo) {
              context.read<HomeCubit>().changeAmount(newText);
            } else {
              context.read<HomeCubit>().changeConvertedAmount(newText);
            }
          },
          onDelete: () {
            final t = controller.text;
            if (t.isEmpty) return;
            
            final currentOffset = controller.selection.baseOffset;
            final offset = currentOffset >= 0 ? currentOffset : t.length;
            
            if (offset == 0) return; // Nothig to delete before cursor
            
            final prefix = t.substring(0, offset - 1);
            final suffix = t.substring(offset);
            final newText = prefix + suffix;
            
            controller.text = newText;
            controller.selection = TextSelection.collapsed(offset: offset - 1);

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
            _keypadController?.close();
            _keypadController = null;
          },
        );
      },
      backgroundColor: Colors.transparent,
      elevation: 10,
    );
    
    _keypadController!.closed.then((_) {
      _keypadController = null;
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
                            _tengoFocus.unfocus();
                            _quieroFocus.unfocus();
                            if (_keypadController != null) {
                              _keypadController!.close();
                              _keypadController = null;
                            }
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
        return ErrorStateCard(message: state.errorMessage);

      case HomeStatus.empty:
        return const EmptyStateCard();

      case HomeStatus.loaded:
        final offer = state.activeOffer;
        if (offer == null) return const EmptyStateCard();

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
      builder: (ctx) => CurrencyPickerBottomSheet(isTengo: isTengo),
    );
  }
}
