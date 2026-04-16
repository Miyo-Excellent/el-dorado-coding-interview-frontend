import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/atoms/underline_tab.dart';

/// **MOLECULE — OfferTabBar**
///
/// A horizontal row of [UnderlineTab] atoms that selects between offer
/// sorting criteria (Mejor Precio / Mejor Reputación).
///
/// Internally stateful so the screen body stays clean.
///
/// ```dart
/// OfferTabBar(
///   tabs: ['💸 Mejor Precio', '⭐ Mejor Reputación'],
///   initialIndex: 0,
///   onTabChanged: (i) => print('Tab $i selected'),
/// )
/// ```
class OfferTabBar extends StatefulWidget {
  const OfferTabBar({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    this.onTabChanged,
  });

  final List<String> tabs;
  final int initialIndex;
  final ValueChanged<int>? onTabChanged;

  @override
  State<OfferTabBar> createState() => _OfferTabBarState();
}

class _OfferTabBarState extends State<OfferTabBar> {
  late int _active;

  @override
  void initState() {
    super.initState();
    _active = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < widget.tabs.length; i++) ...[
          if (i > 0) const SizedBox(width: AppSpacing.xl),
          UnderlineTab(
            label: widget.tabs[i],
            isActive: _active == i,
            onTap: () {
              setState(() => _active = i);
              widget.onTabChanged?.call(i);
            },
          ),
        ],
      ],
    );
  }
}
