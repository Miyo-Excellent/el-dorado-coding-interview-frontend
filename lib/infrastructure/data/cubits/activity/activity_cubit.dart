import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/get_activity_data.dart';

import 'activity_state.dart';

/// Cubit managing activity screen state.
///
/// Currently provides static demo data. In production, this would
/// connect to a transaction history repository.
class ActivityCubit extends Cubit<ActivityState> {
  final GetActivityData getActivityData;

  ActivityCubit({required this.getActivityData}) : super(const ActivityState()) {
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      final json = await getActivityData();
      final groupsJson = json['groups'] as List<dynamic>? ?? [];
      
      final parsedGroups = groupsJson.map((gMap) {
        final g = gMap as Map<String, dynamic>;
        final itemsJson = g['items'] as List<dynamic>? ?? [];
        final items = itemsJson.map((iMap) {
          final i = iMap as Map<String, dynamic>;
          return ActivityItemState(
            iconCode: i['iconCode'] as int,
            title: i['title'] as String,
            time: i['time'] as String,
            status: i['status'] as String,
            statusColor: i['statusColor'] as int,
            amount: i['amount'] as String,
            amountColor: i['amountColor'] as int,
            secondaryAmount: i['secondaryAmount'] as String?,
            strikethrough: i['strikethrough'] as bool? ?? false,
          );
        }).toList();

        return ActivityGroupState(
          dateLabel: g['dateLabel'] as String,
          items: items,
        );
      }).toList();

      emit(state.copyWith(groups: parsedGroups));
    } catch (_) {
      // Ignored for demo
    }
  }

  /// Change the selected filter.
  void selectFilter(int index) {
    emit(state.copyWith(selectedFilterIndex: index));
  }

  /// Refresh activity data.
  Future<void> refresh() async {
    await _loadInitialData();
  }
}
