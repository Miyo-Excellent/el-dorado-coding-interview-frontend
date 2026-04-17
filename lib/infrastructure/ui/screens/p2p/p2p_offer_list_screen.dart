
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/domain/models/offer_model.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/traders/traders_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/traders/traders_state.dart';
import 'package:decimal/decimal.dart';

class P2pOfferListScreen extends StatefulWidget {
  final String amount;
  final String fiatSymbol;
  final String cryptoSymbol;
  final String baseRate;
  final int type; // 0 = sell, 1 = buy
  final List<String> apiPaymentMethods;

  const P2pOfferListScreen({
    super.key,
    required this.amount,
    required this.fiatSymbol,
    required this.cryptoSymbol,
    required this.baseRate,
    required this.type,
    required this.apiPaymentMethods,
  });

  @override
  State<P2pOfferListScreen> createState() => _P2pOfferListScreenState();
}

class _P2pOfferListScreenState extends State<P2pOfferListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TradersCubit>().generateMockOffers(
      baseRate: widget.baseRate,
      type: widget.type,
      cryptoSymbol: widget.cryptoSymbol,
      fiatSymbol: widget.fiatSymbol,
      apiPaymentMethods: widget.apiPaymentMethods,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final isSelling = widget.type == 0;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
        title: Text(
          'Mercado P2P',
          style: tt.titleLarge?.copyWith(
            fontFamily: AppFonts.spaceGrotesk,
            color: colorScheme.primary, 
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Glow
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    colorScheme.primaryContainer.withAlpha(50),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SELECCIONA UNA OFERTA',
                      style: tt.labelMedium?.copyWith(
                        color: colorScheme.primaryContainer,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      isSelling ? 'Vender ${widget.cryptoSymbol}' : 'Comprar ${widget.cryptoSymbol}',
                      style: tt.displaySmall?.copyWith(
                        fontFamily: AppFonts.spaceGrotesk,
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Pagando ${widget.amount} ${isSelling ? widget.cryptoSymbol : widget.fiatSymbol}',
                      style: tt.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: BlocBuilder<TradersCubit, TradersState>(
                  builder: (context, state) {
                    if (state.status == TradersStatus.loading || state.status == TradersStatus.initial) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.offers.isEmpty) {
                      return Center(
                        child: Text(
                          'No hay ofertas de traders para esta configuración.',
                          style: tt.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.xl),
                      itemCount: state.offers.length,
                      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.lg),
                      itemBuilder: (context, index) {
                        final offer = state.offers[index];
                        return _buildOfferTile(context, offer);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOfferTile(BuildContext context, OfferModel offer) {
    final colorScheme = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final val = Decimal.tryParse(widget.amount) ?? Decimal.zero;
    final dRate = Decimal.parse(offer.fiatToCryptoExchangeRate.toString());
    Decimal newBase = Decimal.zero;

    String receiveSymbol = '';

    if (widget.type == 0) {
      newBase = val * dRate;
      receiveSymbol = widget.fiatSymbol;
    } else {
      newBase = (val.toRational() / dRate.toRational()).toDecimal(scaleOnInfinitePrecision: 8);
      receiveSymbol = widget.cryptoSymbol;
    }

    // Limit decimal display size to max 4 decimal points for UI cleanliness
    final String receiveAmountStr = (widget.type == 0)
        ? newBase.toStringAsFixed(2)
        : newBase.toRational().toDouble().toStringAsFixed(4).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');

    final rateRawStr = offer.fiatToCryptoExchangeRate.toStringAsFixed(3).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');

    return InkWell(
      onTap: () {
        context.push('/p2p/transaction', extra: <String, dynamic>{
          'amount': widget.amount,
          'fiatSymbol': widget.fiatSymbol,
          'cryptoSymbol': widget.cryptoSymbol,
          'type': widget.type,
          'offer': offer,
        });
      },
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest, // Crisp white card
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 30,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28, // Visibilidad mejorada
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      backgroundImage: AssetImage('assets/traders/${offer.userId}.png'),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          offer.username,
                          style: tt.titleLarge?.copyWith(
                            color: colorScheme.onSurface, // Mejor contraste
                            fontFamily: AppFonts.spaceGrotesk,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Tasa: $rateRawStr ${widget.fiatSymbol}',
                          style: tt.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.verified_user, size: 14, color: colorScheme.primary),
                            const SizedBox(width: 4),
                            Text(
                              'Confiable',
                              style: tt.labelSmall?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.md),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                  child: Text(
                    widget.type == 0 ? 'VENDER' : 'COMPRAR',
                    style: tt.labelLarge?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Divider(color: colorScheme.surfaceContainerHigh, height: 1),
            const SizedBox(height: AppSpacing.lg),
            // Información Adicional: Límites y Métodos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Límites',
                      style: tt.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${offer.fiatMinLimit} - ${offer.fiatMaxLimit} ${widget.fiatSymbol}',
                      style: tt.bodySmall?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Métodos',
                      style: tt.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      offer.paymentMethods.join(', '),
                      style: tt.bodySmall?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: colorScheme.surface, // Inner subtle differentiation
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recibes',
                    style: tt.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '$receiveAmountStr $receiveSymbol',
                    style: tt.headlineSmall?.copyWith(
                      color: colorScheme.primary, // Alta legibilidad, con primary
                      fontFamily: AppFonts.spaceGrotesk,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
