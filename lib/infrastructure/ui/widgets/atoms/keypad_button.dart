import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';

/// **ATOM — KeypadButton**
///
/// An individual button inside the [NumericKeypad].
/// Can be a number (0-9), a dot, or an action button (del, done).
class KeypadButton extends StatelessWidget {
  const KeypadButton({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Material(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: text == 'del'
              ? Icon(Icons.backspace_outlined, color: colorScheme.onSurfaceVariant)
              : text == 'done'
                  ? Icon(Icons.check, color: colorScheme.primary)
                  : Text(
                      text,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
        ),
      ),
    );
  }
}
