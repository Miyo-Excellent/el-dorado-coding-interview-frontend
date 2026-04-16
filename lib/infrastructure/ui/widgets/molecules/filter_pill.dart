import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';

/// **MOLECULE — FilterPill**
///
/// A horizontal scrollable pill used to filter activity items.
/// Active state uses the golden glow background; inactive uses
/// `surfaceContainerLow` for tonal contrast (No-Line rule).
///
/// ```dart
/// FilterPill(label: 'Todo',    isActive: true)
/// FilterPill(label: 'Cambios', isActive: false)
/// ```
class FilterPill extends StatelessWidget {
  const FilterPill({
    super.key,
    required this.label,
    required this.isActive,
    this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md - 2,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? Theme.of(
                  context,
                ).colorScheme.primaryContainer.withValues(alpha: 0.10)
              : Theme.of(context).colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadius.full),
          boxShadow: isActive ? AppShadows.goldenGlow(opacity: 0.10) : null,
        ),
        child: Text(
          label.toUpperCase(),
          style: tt.labelSmall?.copyWith(
            fontFamily: AppFonts.spaceGrotesk,
            color: isActive
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.onSurfaceVariant,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
