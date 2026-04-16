import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../atoms/app_label.dart';
import '../molecules/setting_item.dart';

/// **ORGANISM — SettingsGroup**
///
/// A labelled section containing a list of [SettingItem] molecules.
/// Header: [AppLabel] atom in uppercase with Space Grotesk tracking.
/// Container: `surfaceContainerLow` + ambient shadow (tonal layering).
///
/// ```dart
/// SettingsGroup(
///   headline: 'CUENTA',
///   items: [
///     SettingItem(icon: Icons.person_outline, label: 'Personal Information'),
///   ],
/// )
/// ```
class SettingsGroup extends StatelessWidget {
  const SettingsGroup({
    super.key,
    required this.headline,
    required this.items,
  });

  final String headline;
  final List<SettingItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ATOM: section label
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: AppLabel(
            headline,
            size: AppLabelSize.sm,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        // Items container — tonal elevation via background shift
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: AppShadows.medium,
          ),
          child: Column(children: items),
        ),
      ],
    );
  }
}
