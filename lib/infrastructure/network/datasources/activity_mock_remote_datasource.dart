import 'package:flutter/material.dart';
import '../../../../infrastructure/storage/hive_storage.dart';

/// Simulates a remote data source fetching the user's transaction history.
///
/// In a real environment, this would use Dio to fetch from the backend.
/// For the interview/demo, it returns static dummy data.
class ActivityMockRemoteDataSource {
  const ActivityMockRemoteDataSource();

  Future<Map<String, dynamic>> fetchActivityData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final txs = HiveStorage.transactions.values.toList();
    
    if (txs.isEmpty) {
      return {'groups': []};
    }

    // Sort by date descending
    txs.sort((a, b) {
      final da = DateTime.tryParse(a['date']?.toString() ?? '') ?? DateTime.now();
      final db = DateTime.tryParse(b['date']?.toString() ?? '') ?? DateTime.now();
      return db.compareTo(da);
    });

    final Map<String, List<Map<String, dynamic>>> grouped = {};

    for (final rawTx in txs) {
      final tx = Map<String, dynamic>.from(rawTx);
      final dt = DateTime.tryParse(tx['date']?.toString() ?? '') ?? DateTime.now();
      final String dateLabel = '${dt.day}/${dt.month}/${dt.year}';
      
      final type = tx['type'].toString(); // SELL_CRYPTO or BUY_CRYPTO
      final fiatSymbol = tx['fiatSymbol'] ?? 'FIAT';
      final cryptoSymbol = tx['cryptoSymbol'] ?? 'CRYPTO';
      
      final String amountStr = tx['amount'].toString();
      final String convertedStr = double.tryParse(tx['convertedAmount']?.toString() ?? '0')?.toStringAsFixed(2) ?? '0.00';

      final String title = type == 'SELL_CRYPTO' 
          ? 'Venta de $cryptoSymbol por $fiatSymbol' 
          : 'Compra de $cryptoSymbol con $fiatSymbol';

      final String mainAmount = type == 'SELL_CRYPTO'
          ? '-$amountStr $cryptoSymbol'
          : '+$convertedStr $cryptoSymbol';

      final String secondaryAmount = type == 'SELL_CRYPTO'
          ? '+$convertedStr $fiatSymbol'
          : '-$amountStr $fiatSymbol';

      grouped.putIfAbsent(dateLabel, () => []).add({
        'iconCode': Icons.swap_horiz.codePoint,
        'title': title,
        'time': '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}',
        'status': 'Completado',
        'statusColor': 0, // 0 = default mapped to success/neutral
        'amount': mainAmount,
        'amountColor': type == 'SELL_CRYPTO' ? 0 : 1, // 0 = standard, 1 = primary (green/yellow)
        'secondaryAmount': secondaryAmount,
        'strikethrough': false,
      });
    }

    final groups = grouped.entries.map((e) {
      return {
        'dateLabel': e.key,
        'items': e.value,
      };
    }).toList();

    return {'groups': groups};
  }
}
