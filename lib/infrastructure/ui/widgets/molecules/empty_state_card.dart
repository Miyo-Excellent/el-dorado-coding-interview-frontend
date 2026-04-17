import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';

/// Empty state card — no offers available.
class EmptyStateCard extends StatelessWidget {
  const EmptyStateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        children: [
          Icon(
            Icons.inbox_outlined,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            size: 48,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Sin ofertas disponibles',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'No hay liquidez para este par de moneda. Prueba con otro monto o divisa.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
