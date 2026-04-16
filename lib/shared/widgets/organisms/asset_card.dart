import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../atoms/circle_icon_container.dart';
import '../atoms/title_subtitle_column.dart';
import '../molecules/asset_amount_column.dart';

/// **ORGANISM — AssetCard**
///
/// Displays a single asset holding. Composed of:
/// - [CircleIconContainer] atom  — tinted icon circle
/// - [TitleSubtitleColumn] atom  — asset name + subtitle
/// - [AssetAmountColumn] molecule — right-aligned amount + USD value
///
/// ```dart
/// AssetCard(
///   icon: Icons.currency_bitcoin,
///   iconColor: Color(0xFF26A17B),
///   name: 'USDT',
///   subtitle: 'Tether',
///   amount: '840.50',
///   usdValue: '≈ \$840.50',
/// )
/// ```
class AssetCard extends StatelessWidget {
  const AssetCard({
    super.key,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg + 4),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Row(
          children: [
            // ATOM: tinted icon circle
            CircleIconContainer(
              icon: icon,
              size: 48,
              iconSize: 22,
              bgColor: iconColor.withValues(alpha: 0.15),
              iconColor: iconColor,
            ),
            const SizedBox(width: AppSpacing.lg),
            // ATOM: name + subtitle
            Expanded(
              child: TitleSubtitleColumn(title: name, subtitle: subtitle),
            ),
            // MOLECULE: amount + usd value
            AssetAmountColumn(amount: amount, usdValue: usdValue),
          ],
        ),
      ),
    );
  }
}
