import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/widgets.dart';
import 'cubit/activity_cubit.dart';
import 'cubit/activity_state.dart';

/// Activity screen.
///
/// **MVVM pattern:**
/// - **Model** → [ActivityItemState], [ActivityGroupState]
/// - **ViewModel** → [ActivityCubit]
/// - **View** → this widget
///
/// Uses [BlocBuilder] for reactive UI. Filter selection is delegated
/// to the Cubit for global state coherence.
class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  static const _filters = ['Todo', 'Cambios', 'Retiros', 'Recargas'];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<ActivityCubit, ActivityState>(
        builder: (context, state) {
          // Convert Cubit state to widget-layer data models
          final feed = state.groups
              .map((g) => ActivityGroupData(
                    dateLabel: g.dateLabel,
                    items: g.items
                        .map((i) => ActivityItem(
                              icon: IconData(i.iconCode, fontFamily: 'MaterialIcons'),
                              title: i.title,
                              time: i.time,
                              status: i.status,
                              statusColor: i.statusColor == 0
                                  ? colorScheme.onSurfaceVariant
                                  : Color(i.statusColor),
                              amount: i.amount,
                              amountColor: i.amountColor == 0
                                  ? null
                                  : Color(i.amountColor),
                              secondaryAmount: i.secondaryAmount,
                              strikethrough: i.strikethrough,
                            ))
                        .toList(),
                  ))
              .toList();

          return Stack(
            children: [
              // ── ATOM: Ambient Glow ───────────────────────────────────
              const AmbientGlowBackground(),

              CustomScrollView(
                slivers: [
                  // ── ORGANISM: Activity App Bar ────────────────────────
                  ElDoradoSliverAppBar(
                    variant: ElDoradoAppBarVariant.page,
                    title: 'ACTIVIDAD',
                    titleColor: colorScheme.primary,
                    titleLetterSpacing: 2,
                    centerTitle: true,
                    leadingIcon: Icons.menu,
                    backgroundOpacity: 0.8,
                  ),

                  // ── MOLECULE: Filter Pills Bar ────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.lg),
                      child: FilterPillsBar(
                        filters: _filters,
                        onFilterChanged: (index) {
                          context.read<ActivityCubit>().selectFilter(index);
                        },
                      ),
                    ),
                  ),

                  // ── ORGANISM: Activity Feed ──────────────────────────
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.xl,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: state.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ActivityFeed(groups: feed),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
