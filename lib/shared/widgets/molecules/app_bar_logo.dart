import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// **MOLECULE — AppBarLogo**
///
/// The branded "El Dorado" title used in the app bar across all screens.
/// Renders in Space Grotesk bold with the golden `primaryContainer` color.
///
/// Two variants:
/// - `AppBarLogoSize.headline` — large golden (Home/Settings)
/// - `AppBarLogoSize.title`    — white medium (Wallet)
///
/// ```dart
/// const AppBarLogo()                              // headline golden
/// const AppBarLogo(size: AppBarLogoSize.title)    // title white
/// ```
enum AppBarLogoSize { headline, title }

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({
    super.key,
    this.size = AppBarLogoSize.headline,
    this.label = 'El Dorado',
  });

  final AppBarLogoSize size;
  final String label;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    final style = size == AppBarLogoSize.headline
        ? tt.headlineSmall?.copyWith(
            color: AppColors.primaryContainer,
            fontFamily: AppFonts.spaceGrotesk,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          )
        : tt.titleLarge?.copyWith(
            fontFamily: AppFonts.spaceGrotesk,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          );

    return Text(label, style: style);
  }
}
