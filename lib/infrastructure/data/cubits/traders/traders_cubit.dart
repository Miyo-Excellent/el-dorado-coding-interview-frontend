import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/domain/models/offer_model.dart';
import 'traders_state.dart';

class TradersCubit extends Cubit<TradersState> {
  TradersCubit() : super(const TradersState());

  void generateMockOffers({
    required String baseRate,
    required int type,
    required String cryptoSymbol,
    required String fiatSymbol,
    required List<String> apiPaymentMethods,
  }) async {
    emit(state.copyWith(status: TradersStatus.loading));

    // Simulate network delay for fetching recommended traders
    await Future.delayed(const Duration(milliseconds: 600));

    final double realRate = double.tryParse(baseRate) ?? 40.0;
    final rng = Random(DateTime.now().millisecondsSinceEpoch);

    final mockTraders = [
      {'id': 'e9fa9d1b-7a1a-4ea9-b2f5-b28e578c187d', 'name': 'Miyo'},
      {'id': 'fbd6e60b-5b5c-4861-b9cd-ec2c82361ac9', 'name': 'Camilo'},
      {'id': '1a8c9e6d-54b9-4672-8874-9f4c3a3b0fa1', 'name': 'Ana'},
      {'id': 'baf8e176-a034-4581-9dfc-5b3a4a11f7c2', 'name': 'CryptoKing'},
      {'id': 'd2a1b9c4-cdeb-4b3f-8089-a27e75826f4a', 'name': 'ElDoradoBot'},
    ];

    final offers = List.generate(5, (index) {
      // Simulate real-world variations in rates (±2%)
      final rateVariation = (rng.nextDouble() * 0.04) - 0.02;
      final fakeRate = realRate * (1 + rateVariation);
      final trader = mockTraders[index];

      final List<String> methods = apiPaymentMethods.isNotEmpty 
          ? apiPaymentMethods 
          : const ['Transferencia', 'Pago Móvil'];

      return OfferModel(
        offerId: 'mock_${DateTime.now().microsecondsSinceEpoch}_$index',
        userId: trader['id']!,
        username: trader['name']!,
        offerStatus: 1,
        offerType: type,
        createdAt: DateTime.now().toIso8601String(),
        description: 'Libero muy rápido',
        cryptoCurrencyId: cryptoSymbol,
        chain: 'TRON',
        fiatCurrencyId: fiatSymbol,
        cryptoMaxLimit: 10000,
        cryptoMinLimit: 10,
        cryptoMarketSize: 5000,
        cryptoAvailableSize: 5000,
        fiatMaxLimit: 500000,
        fiatMinLimit: 500,
        fiatMarketSize: 200000,
        fiatAvailableSize: 200000,
        isDepleted: false,
        fiatToCryptoExchangeRate: fakeRate,
        fiatToCryptoExchangeRateRaw: fakeRate.toStringAsFixed(8),
        paymentMethods: methods,
        paused: false,
        userStatus: 'ONLINE',
        userLastSeen: DateTime.now().millisecondsSinceEpoch,
        allowsThirdPartyPayments: rng.nextBool(),
        visibility: 'PUBLIC',
        orderRequestEnabled: true,
        offerTransactionsEnabled: true,
        escrow: 'ENABLED',
        offerMakerStats: null,
      );
    });

    // Sort by best rate
    // If selling crypto, higher rate is better
    // If buying crypto, lower rate is better
    offers.sort((a, b) {
      if (type == 0) {
        return b.fiatToCryptoExchangeRate.compareTo(a.fiatToCryptoExchangeRate);
      } else {
        return a.fiatToCryptoExchangeRate.compareTo(b.fiatToCryptoExchangeRate);
      }
    });

    emit(state.copyWith(
      status: TradersStatus.loaded,
      offers: offers,
    ));
  }
}
