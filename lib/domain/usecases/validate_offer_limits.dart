import 'package:el_dorado_coding_interview_frontend/domain/models/offer_model.dart';

/// Use case: Validate if an input amount falls within the limits of a given offer.
///
/// Ensures local frontend safety checks before/during P2P requests based on
/// the minimum and maximum boundaries established by the offer maker.
class ValidateOfferLimits {
  const ValidateOfferLimits();

  /// Executes limit validation.
  ///
  /// - [amount]: Raw string input.
  /// - [type]: Operation type (0 = CRYPTO→FIAT, 1 = FIAT→CRYPTO).
  /// - [offer]: The currently selected offer.
  ///
  /// Returns `true` if the amount falls strictly between [minLimit] and [maxLimit] (inclusive).
  bool call({
    required String amount,
    required int type,
    required OfferModel offer,
  }) {
    final inputAmount = double.tryParse(amount) ?? 0.0;
    if (inputAmount <= 0) return false;

    // Depending on the transaction direction, the input amount targets
    // either the Crypto threshold or Fiat threshold.
    if (type == 0) {
      // User inputs Crypto amount (e.g., 5.00 USDT)
      return inputAmount >= offer.cryptoMinLimit &&
             inputAmount <= offer.cryptoMaxLimit;
    } else {
      // User inputs Fiat amount (e.g., 50.00 VES)
      return inputAmount >= offer.fiatMinLimit &&
             inputAmount <= offer.fiatMaxLimit;
    }
  }
}
