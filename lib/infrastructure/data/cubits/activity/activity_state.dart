import 'package:equatable/equatable.dart';

/// State for the activity screen.
class ActivityState extends Equatable {
  final List<ActivityGroupState> groups;
  final int selectedFilterIndex;
  final bool isLoading;

  const ActivityState({
    this.groups = const [],
    this.selectedFilterIndex = 0,
    this.isLoading = false,
  });

  ActivityState copyWith({
    List<ActivityGroupState>? groups,
    int? selectedFilterIndex,
    bool? isLoading,
  }) {
    return ActivityState(
      groups: groups ?? this.groups,
      selectedFilterIndex: selectedFilterIndex ?? this.selectedFilterIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [groups, selectedFilterIndex, isLoading];
}

/// A group of activity items under a date label.
class ActivityGroupState extends Equatable {
  final String dateLabel;
  final List<ActivityItemState> items;

  const ActivityGroupState({
    required this.dateLabel,
    required this.items,
  });

  @override
  List<Object?> get props => [dateLabel, items];
}

/// Individual activity item.
class ActivityItemState extends Equatable {
  final int iconCode;
  final String title;
  final String time;
  final String status;
  final int statusColor;
  final String amount;
  final int amountColor;
  final String? secondaryAmount;
  final bool strikethrough;

  const ActivityItemState({
    required this.iconCode,
    required this.title,
    required this.time,
    required this.status,
    required this.statusColor,
    required this.amount,
    required this.amountColor,
    this.secondaryAmount,
    this.strikethrough = false,
  });

  @override
  List<Object?> get props => [title, time, status, amount];
}
