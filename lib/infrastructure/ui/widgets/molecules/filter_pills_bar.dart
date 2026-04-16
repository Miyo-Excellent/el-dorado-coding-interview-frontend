import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'filter_pill.dart';

/// **MOLECULE — FilterPillsBar**
///
/// A horizontally scrollable row of [FilterPill] atoms.
/// Manages its own active-index state so callers stay stateless.
///
/// ```dart
/// FilterPillsBar(
///   filters: ['Todo', 'Cambios', 'Retiros', 'Recargas'],
///   onFilterChanged: (i) => print('Filter $i selected'),
/// )
/// ```
class FilterPillsBar extends StatefulWidget {
  const FilterPillsBar({
    super.key,
    required this.filters,
    this.initialIndex = 0,
    this.onFilterChanged,
    this.height = 44,
  });

  final List<String> filters;
  final int initialIndex;
  final ValueChanged<int>? onFilterChanged;
  final double height;

  @override
  State<FilterPillsBar> createState() => _FilterPillsBarState();
}

class _FilterPillsBarState extends State<FilterPillsBar> {
  late int _active;

  @override
  void initState() {
    super.initState();
    _active = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        scrollDirection: Axis.horizontal,
        itemCount: widget.filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, i) => FilterPill(
          label: widget.filters[i],
          isActive: _active == i,
          onTap: () {
            setState(() => _active = i);
            widget.onFilterChanged?.call(i);
          },
        ),
      ),
    );
  }
}
