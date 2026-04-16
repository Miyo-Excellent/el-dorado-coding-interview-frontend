import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// **ATOM — PrimaryButton**
///
/// The full-width "Golden" CTA button from the design system.
///
/// Background: `primaryContainer` (#deed00) · Text: `onPrimary` (#2f3300).
/// SizedBox enforces full width. Uses the theme's [ElevatedButtonTheme]
/// so token overrides are applied automatically.
///
/// ```dart
/// PrimaryButton(label: 'Cambiar a COP', onPressed: () {})
/// PrimaryButton(label: 'Confirmar', isLoading: true)
/// ```
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.onPrimary,
                ),
              )
            : Text(
                label,
                style: tt.titleMedium?.copyWith(
                  fontFamily: AppFonts.spaceGrotesk,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onPrimary,
                  fontSize: 17,
                ),
              ),
      ),
    );
  }
}
