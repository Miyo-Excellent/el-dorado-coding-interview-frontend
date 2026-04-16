/// Use case: Calculate the exact conversion result between crypto and fiat.
///
/// Encapsulates the mathematical rule defined by the business:
/// - CRYPTO → FIAT (`type = 0`): `fiat = crypto * rate`
/// - FIAT → CRYPTO (`type = 1`): `crypto = fiat / rate`
class CalculateConversion {
  const CalculateConversion();

  /// Execute the conversion.
  ///
  /// - [amount]: The raw string input from the user.
  /// - [rate]: The `fiatToCryptoExchangeRate` from the active offer.
  /// - [type]: The operation direction (0 = Sell Crypto, 1 = Buy Crypto).
  double call({
    required String amount,
    required double rate,
    required int type,
  }) {
    final inputAmount = double.tryParse(amount) ?? 0.0;

    if (rate == 0 || inputAmount == 0) return 0.0;

    if (type == 0) {
      // User is exchanging Crypto for Fiat
      return inputAmount * rate;
    } else {
      // User is exchanging Fiat for Crypto
      return inputAmount / rate;
    }
  }
}
