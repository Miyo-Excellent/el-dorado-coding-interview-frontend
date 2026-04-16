import 'package:equatable/equatable.dart';
import '../../data/models/offer_model.dart';

/// Possible statuses for the exchange screen.
enum ExchangeStatus { initial, loading, loaded, empty, error }

/// State for [ExchangeBloc].
class ExchangeState extends Equatable {
  final ExchangeStatus status;

  /// `0` = CRYPTO→FIAT, `1` = FIAT→CRYPTO
  final int type;

  final String fiatCurrencyId;
  final String amount;

  /// Currently selected offer tab: 0 = byPrice, 1 = byReputation
  final int selectedOfferTab;

  /// Best price offer (may be null if no data).
  final OfferModel? byPrice;

  /// Best reputation offer (may be null if no data).
  final OfferModel? byReputation;

  /// Calculated conversion result.
  final double convertedAmount;

  /// Error message (only when status == error).
  final String errorMessage;

  const ExchangeState({
    this.status = ExchangeStatus.initial,
    this.type = 0,
    this.fiatCurrencyId = 'COP',
    this.amount = '50',
    this.selectedOfferTab = 0,
    this.byPrice,
    this.byReputation,
    this.convertedAmount = 0,
    this.errorMessage = '',
  });

  /// The currently displayed offer based on the selected tab.
  OfferModel? get activeOffer =>
      selectedOfferTab == 0 ? byPrice : byReputation;

  /// Limits text for the exchange card.
  String get limitsText {
    final offer = byPrice;
    if (offer == null) return '';
    return 'Límites: ${offer.cryptoMinLimit.toStringAsFixed(2)} – '
        '${offer.cryptoMaxLimit.toStringAsFixed(2)} USDT';
  }

  /// Formatted converted amount for display.
  String get formattedConvertedAmount {
    if (convertedAmount >= 1000) {
      final parts = convertedAmount.toStringAsFixed(2).split('.');
      final intPart = parts[0].replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'),
        (m) => '${m[1]},',
      );
      return '$intPart.${parts[1]}';
    }
    return convertedAmount.toStringAsFixed(2);
  }

  ExchangeState copyWith({
    ExchangeStatus? status,
    int? type,
    String? fiatCurrencyId,
    String? amount,
    int? selectedOfferTab,
    OfferModel? byPrice,
    OfferModel? byReputation,
    double? convertedAmount,
    String? errorMessage,
    bool clearOffers = false,
  }) {
    return ExchangeState(
      status: status ?? this.status,
      type: type ?? this.type,
      fiatCurrencyId: fiatCurrencyId ?? this.fiatCurrencyId,
      amount: amount ?? this.amount,
      selectedOfferTab: selectedOfferTab ?? this.selectedOfferTab,
      byPrice: clearOffers ? null : (byPrice ?? this.byPrice),
      byReputation:
          clearOffers ? null : (byReputation ?? this.byReputation),
      convertedAmount: convertedAmount ?? this.convertedAmount,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        type,
        fiatCurrencyId,
        amount,
        selectedOfferTab,
        byPrice,
        byReputation,
        convertedAmount,
        errorMessage,
      ];
}
