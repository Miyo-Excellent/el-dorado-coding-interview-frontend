import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/domain/models/offer_model.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/storage/hive_storage.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/atoms/primary_button.dart';

class P2pTransactionScreen extends StatefulWidget {
  final String amount;
  final String fiatSymbol;
  final String cryptoSymbol;
  final int type;
  final OfferModel offer;

  const P2pTransactionScreen({
    super.key,
    required this.amount,
    required this.fiatSymbol,
    required this.cryptoSymbol,
    required this.type,
    required this.offer,
  });

  @override
  State<P2pTransactionScreen> createState() => _P2pTransactionScreenState();
}

enum TxState { waitingForUser, waitingForPeer, completed }

class _P2pTransactionScreenState extends State<P2pTransactionScreen> {
  TxState _currentState = TxState.waitingForUser;
  bool _isProcessing = false;

  Future<void> _advanceState() async {
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    if (_currentState == TxState.waitingForUser) {
      // Simulate transferring money/crypto
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _currentState = TxState.waitingForPeer;
        _isProcessing = false;
      });

      // Automatically advance to completed after some seconds to mimic peer confirming
      _simulatePeerAction();
    } else if (_currentState == TxState.completed) {
      // Finish and return
      context.go('/');
    }
  }

  Future<void> _simulatePeerAction() async {
    await Future.delayed(const Duration(seconds: 4));
    if (!mounted) return;

    // Save to Hive to complete the cycle
    final tx = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'date': DateTime.now().toIso8601String(),
      'type': widget.type == 0 ? 'SELL_CRYPTO' : 'BUY_CRYPTO',
      'amount': widget.amount,
      'convertedAmount': widget.type == 0 
          ? (double.parse(widget.amount) * widget.offer.fiatToCryptoExchangeRate).toString()
          : (double.parse(widget.amount) / widget.offer.fiatToCryptoExchangeRate).toString(),
      'fiatSymbol': widget.fiatSymbol,
      'cryptoSymbol': widget.cryptoSymbol,
      'makerId': widget.offer.userId,
      'makerUsername': widget.offer.username,
      'rate': widget.offer.fiatToCryptoExchangeRateRaw,
    };
    await HiveStorage.transactions.add(tx);

    setState(() {
      _currentState = TxState.completed;
    });
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
          'Orden de Transacción',
          style: tt.headlineSmall?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProgressIndicator(colorScheme),
              const SizedBox(height: AppSpacing.xxl),
              _buildStatusHeader(tt, colorScheme),
              const SizedBox(height: AppSpacing.xxl),
              _buildTransactionInfo(tt, colorScheme, isSelling),
              const Spacer(),
              _buildActionButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(ColorScheme colorScheme) {
    double progress = 0.33;
    if (_currentState == TxState.waitingForPeer) progress = 0.66;
    if (_currentState == TxState.completed) progress = 1.0;

    return LinearProgressIndicator(
      value: progress,
      backgroundColor: colorScheme.surfaceContainerHigh,
      color: colorScheme.primaryContainer,
      minHeight: 8,
      borderRadius: BorderRadius.circular(4),
    );
  }

  Widget _buildStatusHeader(TextTheme tt, ColorScheme colorScheme) {
    String title = '';
    String subtitle = '';
    IconData icon = Icons.info_outline;
    Color iconColor = colorScheme.primaryContainer;

    switch (_currentState) {
      case TxState.waitingForUser:
        title = 'Realiza el pago';
        subtitle = 'Transfiere los fondos a la cuenta indicada para continuar.';
        icon = Icons.payment;
        break;
      case TxState.waitingForPeer:
        title = 'Esperando a ${widget.offer.username}';
        subtitle = 'El vendedor está verificando tu transacción. Esto puede tomar unos minutos.';
        icon = Icons.hourglass_empty;
        break;
      case TxState.completed:
        title = '¡Transacción Exitosa!';
        subtitle = 'Los fondos han sido liberados y están ahora en tu billetera.';
        icon = Icons.check_circle;
        iconColor = Colors.greenAccent;
        break;
    }

    return Column(
      children: [
        Icon(icon, size: 64, color: iconColor),
        const SizedBox(height: AppSpacing.md),
        Text(title, style: tt.displaySmall?.copyWith(color: colorScheme.primary, fontSize: 28), textAlign: TextAlign.center),
        const SizedBox(height: AppSpacing.sm),
        Text(subtitle, style: tt.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant), textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildTransactionInfo(TextTheme tt, ColorScheme colorScheme, bool isSelling) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colorScheme.surfaceContainer),
      ),
      child: Column(
        children: [
          _buildInfoRow('Contraparte', widget.offer.username, tt, colorScheme),
          const Divider(height: AppSpacing.xl),
          _buildInfoRow('Monto a enviar', '${widget.amount} ${isSelling ? widget.cryptoSymbol : widget.fiatSymbol}', tt, colorScheme),
          const SizedBox(height: AppSpacing.sm),
          _buildInfoRow('Monto a recibir', '${(widget.type == 0 ? double.parse(widget.amount) * widget.offer.fiatToCryptoExchangeRate : double.parse(widget.amount) / widget.offer.fiatToCryptoExchangeRate).toStringAsFixed(2)} ${isSelling ? widget.fiatSymbol : widget.cryptoSymbol}', tt, colorScheme),
          const Divider(height: AppSpacing.xl),
          _buildInfoRow('Tasa de Cambio', '1 ${widget.cryptoSymbol} = ${widget.offer.fiatToCryptoExchangeRateRaw} ${widget.fiatSymbol}', tt, colorScheme),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, TextTheme tt, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: tt.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
        Text(value, style: tt.titleSmall?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildActionButton() {
    if (_currentState == TxState.waitingForPeer) {
      return PrimaryButton(
        label: 'Procesando...',
        onPressed: null, // Disabled
      );
    }

    String label = _currentState == TxState.completed ? 'Volver al Inicio' : 'He realizado el pago';

    return PrimaryButton(
      label: _isProcessing ? 'Cargando...' : label,
      onPressed: _isProcessing ? null : _advanceState,
    );
  }
}
