import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/atoms/circle_icon_container.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/atoms/title_subtitle_column.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/atoms/amount_column.dart';

/// **MOLECULE — TransactionRow**
///
/// A single list row representing a financial transaction. Composes:
/// - [CircleIconContainer] — leading icon
/// - [TitleSubtitleColumn] — center copy
/// - [AmountColumn] — right-aligned amount with optional secondary
///
/// Used in both the Wallet recent-activity list and the Activity screen.
///
/// ```dart
/// TransactionRow(
///   icon: Icons.swap_horiz,
///   title: 'Cambio USDT a COP',
///   subtitle: 'Today, 14:30',
///   amount: '-\$50.00',
/// )
/// ```
class TransactionRow extends StatelessWidget {
  const TransactionRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.amountColor,
    this.secondaryAmount,
    this.iconBgColor,
    this.iconColor,
    this.strikethrough = false,
    this.onTap,
  });

  final IconData icon;
  final Color? iconBgColor;
  final Color? iconColor;
  final String title;
  final String subtitle;
  final String amount;
  final Color? amountColor;
  final String? secondaryAmount;
  final bool strikethrough;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        child: Row(
          children: [
            // ATOM: leading icon
            CircleIconContainer(
              icon: icon,
              bgColor: iconBgColor,
              iconColor: iconColor,
            ),
            const SizedBox(width: AppSpacing.lg),
            // ATOM: title + subtitle
            Expanded(
              child: TitleSubtitleColumn(title: title, subtitle: subtitle),
            ),
            // ATOM: amount column
            AmountColumn(
              amount: amount,
              amountColor: amountColor,
              secondaryAmount: secondaryAmount,
              strikethrough: strikethrough,
            ),
          ],
        ),
      ),
    );
  }
}
