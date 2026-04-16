import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../organisms/settings_group.dart';
import '../molecules/setting_item.dart';

/// Data class for a settings section in [SettingsBody].
class SettingsSection {
  const SettingsSection({
    required this.headline,
    required this.items,
  });

  final String headline;
  final List<SettingItem> items;
}

/// **ORGANISM — SettingsBody**
///
/// Renders a vertical sequence of [SettingsGroup] organisms, each separated
/// by `AppSpacing.xxl`. Accepts a list of [SettingsSection] data objects.
///
/// This eliminates the repeated `SettingsGroup(...) + SizedBox` pattern
/// from the Settings screen body.
///
/// ```dart
/// SettingsBody(
///   sections: [
///     SettingsSection(headline: 'CUENTA', items: [...]),
///     SettingsSection(headline: 'PAGOS',  items: [...]),
///   ],
/// )
/// ```
class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key, required this.sections});

  final List<SettingsSection> sections;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < sections.length; i++) ...[
          SettingsGroup(
            headline: sections[i].headline,
            items: sections[i].items,
          ),
          if (i < sections.length - 1) const SizedBox(height: AppSpacing.xxl),
        ],
      ],
    );
  }
}
