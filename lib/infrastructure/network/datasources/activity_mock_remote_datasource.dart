import 'package:flutter/material.dart';

/// Simulates a remote data source fetching the user's transaction history.
///
/// In a real environment, this would use Dio to fetch from the backend.
/// For the interview/demo, it returns static dummy data.
class ActivityMockRemoteDataSource {
  const ActivityMockRemoteDataSource();

  Future<Map<String, dynamic>> fetchActivityData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    // Return dummy JSON response
    return {
      'groups': [
        {
          'dateLabel': 'Hoy',
          'items': [
            {
              'iconCode': Icons.swap_horiz.codePoint,
              'title': 'Cambio USDT a COP',
              'time': '14:30',
              'status': 'Completado',
              'statusColor': 0,
              'amount': '-50.00 USDT',
              'amountColor': 0,
              'secondaryAmount': '+195,000 COP',
            },
            {
              'iconCode': Icons.arrow_downward.codePoint,
              'title': 'Recarga USDT',
              'time': '10:15',
              'status': 'Pendiente',
              'statusColor': 1,
              'amount': '+100.00 USDT',
              'amountColor': 0,
            },
          ],
        },
        {
          'dateLabel': 'Ayer',
          'items': [
            {
              'iconCode': Icons.arrow_upward.codePoint,
              'title': 'Retiro a Banco',
              'time': '18:45',
              'status': 'Completado',
              'statusColor': 0,
              'amount': '-500,000 COP',
              'amountColor': 0,
            },
            {
              'iconCode': Icons.swap_horiz.codePoint,
              'title': 'Cambio USDC a VES',
              'time': '09:20',
              'status': 'Cancelado',
              'statusColor': 2,
              'amount': '-20.00 USDC',
              'amountColor': 0,
              'strikethrough': true,
            },
          ],
        },
      ]
    };
  }
}
