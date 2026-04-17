import 'package:decimal/decimal.dart';

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
  Decimal call({
    required String amount,
    required double rate,
    required int type,
  }) {
    if (rate == 0 || amount.isEmpty) return Decimal.zero;

    final parsedAmount = Decimal.tryParse(amount);
    if (parsedAmount == null) return Decimal.zero;

    // We can parse the rate double safely
    final dRate = Decimal.parse(rate.toString());

    if (type == 0) {
      // User is exchanging Crypto for Fiat
      return (parsedAmount * dRate);
    } else {
      // User is exchanging Fiat for Crypto
      // Since it's division, we must handle precision. The rational package (used by Decimal)
      // returns a Rational natively. By calling toDecimal() with a scaleOnInfinitePrecision, it avoids infinite repeating decimals.
      return (parsedAmount.toRational() / dRate.toRational()).toDecimal(scaleOnInfinitePrecision: 8);
    }
  }
}
