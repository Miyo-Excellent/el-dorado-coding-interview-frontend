import 'package:flutter/material.dart';

/// **ATOM — SettingItemTrailing**
///
/// The right-side trailing region of a [SettingItem]:
/// an optional value label followed by an optional chevron icon.
///
/// ```dart
/// const SettingItemTrailing()                         // chevron only
/// SettingItemTrailing(label: 'USD')                   // label + chevron
/// const SettingItemTrailing(showChevron: false)       // nothing
/// ```
class SettingItemTrailing extends StatelessWidget {
  const SettingItemTrailing({
    super.key,
    this.label,
    this.showChevron = true,
  });

  final String? label;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: tt.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(width: 4),
        ],
        if (showChevron)
          Icon(
            Icons.chevron_right,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            size: 20,
          ),
      ],
    );
  }
}
