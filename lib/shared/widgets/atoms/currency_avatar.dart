import 'package:flutter/material.dart';

/// **ATOM — CurrencyAvatar**
///
/// A small filled circle displaying a currency symbol character
/// (e.g. `₮`, `$`, `€`). Used inside currency selector pills.
///
/// ```dart
/// CurrencyAvatar(color: Color(0xFF26A17B), symbol: '₮')
/// CurrencyAvatar(color: Color(0xFFFFD100), symbol: '\$')
/// ```
class CurrencyAvatar extends StatelessWidget {
  const CurrencyAvatar({
    super.key,
    required this.color,
    required this.symbol,
    this.radius = 10,
  });

  final Color color;
  final String symbol;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: Text(
        symbol,
        style: TextStyle(
          fontSize: radius * 0.9,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1,
        ),
      ),
    );
  }
}
