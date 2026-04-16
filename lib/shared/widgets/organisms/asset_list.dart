import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../organisms/asset_card.dart';
import '../molecules/section_header.dart';

/// Data class for a single asset in [AssetList].
class AssetEntry {
  const AssetEntry({
    required this.icon,
    required this.iconColor,
    required this.name,
    required this.subtitle,
    required this.amount,
    required this.usdValue,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String name;
  final String subtitle;
  final String amount;
  final String usdValue;
  final VoidCallback? onTap;
}

/// **ORGANISM — AssetList**
///
/// A titled section containing a list of [AssetCard] organisms.
/// Header: [SectionHeader] molecule with an optional "Ver todos" trailing link.
/// Cards are separated by `AppSpacing.md` following the No-Line rule.
///
/// ```dart
/// AssetList(
///   onSeeAll: () {},
///   assets: [
///     AssetEntry(
///       icon: Icons.currency_bitcoin,
///       iconColor: Color(0xFF26A17B),
///       name: 'USDT',
///       subtitle: 'Tether',
///       amount: '840.50',
///       usdValue: '≈ \$840.50',
///     ),
///   ],
/// )
/// ```
class AssetList extends StatelessWidget {
  const AssetList({
    super.key,
    required this.assets,
    this.onSeeAll,
    this.label = 'ACTIVOS',
    this.title = 'Mis Activos',
  });

  final List<AssetEntry> assets;
  final VoidCallback? onSeeAll;
  final String label;
  final String title;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── MOLECULE: Section header with optional trailing ────────────────
        SectionHeader(
          label: label,
          title: title,
          trailing: onSeeAll != null
              ? TextButton(
                  onPressed: onSeeAll,
                  child: Text(
                    'Ver todos',
                    style: tt.labelMedium
                        ?.copyWith(color: AppColors.primaryContainer),
                  ),
                )
              : null,
        ),
        const SizedBox(height: AppSpacing.xl),

        // ── ORGANISM: Asset Cards separated by space (No-Line rule) ────────
        for (int i = 0; i < assets.length; i++) ...[
          AssetCard(
            icon: assets[i].icon,
            iconColor: assets[i].iconColor,
            name: assets[i].name,
            subtitle: assets[i].subtitle,
            amount: assets[i].amount,
            usdValue: assets[i].usdValue,
            onTap: assets[i].onTap,
          ),
          if (i < assets.length - 1) const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}
