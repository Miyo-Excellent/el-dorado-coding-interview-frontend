import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import 'activity_state.dart';

/// Cubit managing activity screen state.
///
/// Currently provides static demo data. In production, this would
/// connect to a transaction history repository.
class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(const ActivityState()) {
    _loadInitialData();
  }

  void _loadInitialData() {
    emit(state.copyWith(
      groups: [
        ActivityGroupState(
          dateLabel: 'Hoy',
          items: [
            ActivityItemState(
              iconCode: Icons.swap_horiz.codePoint,
              title: 'Cambio USDT a COP',
              time: '14:30',
              status: 'Completado',
              statusColor: 0, // resolved from theme
              amount: '-50.00 USDT',
              amountColor: 0, // resolved from theme
              secondaryAmount: '+195,000 COP',
            ),
            ActivityItemState(
              iconCode: Icons.arrow_downward.codePoint,
              title: 'Recarga USDT',
              time: '10:15',
              status: 'Pendiente',
              statusColor: AppColors.primaryContainer.toARGB32(),
              amount: '+100.00 USDT',
              amountColor: 0, // resolved from theme
            ),
          ],
        ),
        ActivityGroupState(
          dateLabel: 'Ayer',
          items: [
            ActivityItemState(
              iconCode: Icons.arrow_upward.codePoint,
              title: 'Retiro a Banco',
              time: '18:45',
              status: 'Completado',
              statusColor: 0, // resolved from theme
              amount: '-500,000 COP',
              amountColor: 0, // resolved from theme (secondary style)
            ),
            ActivityItemState(
              iconCode: Icons.swap_horiz.codePoint,
              title: 'Cambio USDC a VES',
              time: '09:20',
              status: 'Cancelado',
              statusColor: AppColors.error.toARGB32(),
              amount: '-20.00 USDC',
              amountColor: 0, // resolved from theme
              strikethrough: true,
            ),
          ],
        ),
      ],
    ));
  }

  /// Change the selected filter.
  void selectFilter(int index) {
    emit(state.copyWith(selectedFilterIndex: index));
  }

  /// Refresh activity data.
  void refresh() {
    _loadInitialData();
  }
}
