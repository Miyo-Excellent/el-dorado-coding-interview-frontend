import 'package:equatable/equatable.dart';
import 'package:decimal/decimal.dart';
import 'package:el_dorado_coding_interview_frontend/domain/models/offer_model.dart';
import 'package:el_dorado_coding_interview_frontend/domain/models/currency_model.dart';

/// Possible statuses for the home screen.
enum HomeStatus { initial, loading, loaded, empty, error }

const defaultFiat = CurrencyModel(id: 'USD', type: 0, symbol: 'USD', symbolShort: '\$', name: 'Dólares', iconUrl: 'https://cdn.eldorado.io/api/assets/fiat_currencies/currency_usd.png');
const defaultCrypto = CurrencyModel(id: 'TATUM-TRON-USDT', type: 1, symbol: 'USDT', symbolShort: '₮', name: 'Tether', iconUrl: 'https://cdn.eldorado.io/api/assets/cripto_currencies/TATUM-TRON-USDT.png');

/// State for [HomeCubit].
class HomeState extends Equatable {
  final HomeStatus status;

  /// `0` = CRYPTO→FIAT, `1` = FIAT→CRYPTO
  final int type;

  final CurrencyModel fiatCurrency;
  final CurrencyModel cryptoCurrency;
  final String amount;

  /// Currently selected offer tab: 0 = byPrice, 1 = byReputation
  final int selectedOfferTab;

  /// Best price offer (may be null if no data).
  final OfferModel? byPrice;

  /// Best reputation offer (may be null if no data).
  final OfferModel? byReputation;

  /// Calculated conversion result in perfect decimal precision.
  final Decimal convertedAmount;

  /// Error message (only when status == error).
  final String errorMessage;

  HomeState({
    this.status = HomeStatus.initial,
    this.type = 1,
    this.fiatCurrency = defaultFiat,
    this.cryptoCurrency = defaultCrypto,
    this.amount = '50',
    this.selectedOfferTab = 0,
    this.byPrice,
    this.byReputation,
    Decimal? convertedAmount,
    this.errorMessage = '',
  }) : convertedAmount = convertedAmount ?? Decimal.zero;

  /// The currently displayed offer based on the selected tab.
  OfferModel? get activeOffer => selectedOfferTab == 0 ? byPrice : byReputation;

  /// Limits text for the exchange card.
  String get limitsText {
    final offer = byPrice;
    if (offer == null) return '';
    return 'Límites: ${offer.cryptoMinLimit.toStringAsFixed(2)} – '
        '${offer.cryptoMaxLimit.toStringAsFixed(2)} ${cryptoCurrency.symbol}';
  }

  /// Formatted converted amount for display.
  String get formattedConvertedAmount {
    if (convertedAmount == Decimal.zero && amount.isEmpty) return '';
    
    // Type 0 -> Fiat es output (2 decimales). Type 1 -> Crypto es output (8 decimales)
    final bool isCryptoOutput = type == 1;
    final int decimalsCount = isCryptoOutput ? 8 : 2;
    
    String formatted = convertedAmount.toStringAsFixed(decimalsCount);
    
    // Si la cantidad es muy precisa, limpiamos los ceros extra al final para crypto
    if (isCryptoOutput && formatted.contains('.')) {
       formatted = formatted.replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');
    }

    if (convertedAmount >= Decimal.fromInt(1000) && !isCryptoOutput) {
      final parts = formatted.split('.');
      final intPart = parts[0].replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'),
        (m) => '${m[1]},',
      );
      return '$intPart.${parts.length > 1 ? parts[1] : 0}';
    }
    return formatted;
  }

  HomeState copyWith({
    HomeStatus? status,
    int? type,
    CurrencyModel? fiatCurrency,
    CurrencyModel? cryptoCurrency,
    String? amount,
    int? selectedOfferTab,
    OfferModel? byPrice,
    OfferModel? byReputation,
    Decimal? convertedAmount,
    String? errorMessage,
    bool clearOffers = false,
  }) {
    return HomeState(
      status: status ?? this.status,
      type: type ?? this.type,
      fiatCurrency: fiatCurrency ?? this.fiatCurrency,
      cryptoCurrency: cryptoCurrency ?? this.cryptoCurrency,
      amount: amount ?? this.amount,
      selectedOfferTab: selectedOfferTab ?? this.selectedOfferTab,
      byPrice: clearOffers ? null : (byPrice ?? this.byPrice),
      byReputation: clearOffers ? null : (byReputation ?? this.byReputation),
      convertedAmount: convertedAmount ?? this.convertedAmount,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    type,
    fiatCurrency,
    cryptoCurrency,
    amount,
    selectedOfferTab,
    byPrice,
    byReputation,
    convertedAmount,
    errorMessage,
  ];
}
