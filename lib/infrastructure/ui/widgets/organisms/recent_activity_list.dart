import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/atoms/ghost_border_container.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/molecules/section_title_row.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/molecules/transaction_row.dart';

/// Data class for a single transaction row displayed in [RecentActivityList].
class RecentTransaction {
  const RecentTransaction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.amountColor = AppColors.primary,
    this.iconBgColor,
    this.iconColor = AppColors.primary,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final Color amountColor;
  final Color? iconBgColor;
  final Color iconColor;
  final VoidCallback? onTap;
}

/// **ORGANISM — RecentActivityList**
///
/// A titled section of recent transactions. Composed of:
/// - [SectionTitleRow] molecule — title + "Ver todo" link
/// - [GhostBorderContainer] atom — surfaceContainerLow shell with ghost border
/// - [TransactionRow] molecules — one per transaction
///
/// ```dart
/// RecentActivityList(
///   transactions: [ RecentTransaction(…) ],
///   onSeeAll: () {},
/// )
/// ```
class RecentActivityList extends StatelessWidget {
  const RecentActivityList({
    super.key,
    required this.transactions,
    this.title = 'Actividad Reciente',
    this.onSeeAll,
  });

  final List<RecentTransaction> transactions;
  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // MOLECULE: section title + Ver todo
        SectionTitleRow(title: title, onSeeAll: onSeeAll),
        const SizedBox(height: AppSpacing.lg),
        // ATOM: ghost border container
        GhostBorderContainer(
          child: Column(
            children: [
              for (final tx in transactions)
                TransactionRow(
                  icon: tx.icon,
                  iconBgColor: tx.iconBgColor,
                  iconColor: tx.iconColor,
                  title: tx.title,
                  subtitle: tx.subtitle,
                  amount: tx.amount,
                  amountColor: tx.amountColor,
                  onTap: tx.onTap,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
