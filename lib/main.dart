import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'domain/di/injection_container.dart';
import 'infrastructure/router/app_router.dart';
import 'infrastructure/storage/hive_storage.dart';
import 'infrastructure/ui/theme/registry.dart';
import 'infrastructure/data/cubits/theme/theme_cubit.dart';
import 'infrastructure/data/cubits/home/home_cubit.dart';
import 'infrastructure/data/cubits/wallet/wallet_cubit.dart';
import 'infrastructure/data/cubits/activity/activity_cubit.dart';
import 'infrastructure/data/cubits/currency/currency_cubit.dart';
import 'infrastructure/data/cubits/traders/traders_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Allow Google Fonts to download missing font variants at runtime.
  // (Manrope for Golden Standard, Space Grotesk for Electric Alchemist)
  GoogleFonts.config.allowRuntimeFetching = true;

  // Initialize local storage
  await HiveStorage.init();

  // Configure dependency injection
  configureDependencies();

  runApp(const ElDoradoApp());
}

/// Root application widget.
///
/// Wraps the entire app with [MultiBlocProvider] to make global state
/// available to all screens via the widget tree.
///
/// Listens to [ThemeCubit] state ([AppThemeVariant]) to select the
/// correct pair of dark/light [ThemeData] and [ThemeMode].
///
/// Theme mapping:
/// ┌──────────────────┬─────────────────────────────────┬──────────────┐
/// │ AppThemeVariant  │ ThemeData pair                  │ ThemeMode    │
/// ├──────────────────┼─────────────────────────────────┼──────────────┤
/// │ goldenLight      │ GS Light / GS Dark              │ light        │
/// │ goldenDark       │ GS Light / GS Dark              │ dark         │
/// │ alchemistDark    │ EA Light / EA Dark              │ dark         │
/// │ alchemistLight   │ EA Light / EA Dark              │ light        │
/// └──────────────────┴─────────────────────────────────┴──────────────┘
class ElDoradoApp extends StatelessWidget {
  const ElDoradoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // ── Global Theme State ────────────────────────────────────────────
        BlocProvider<ThemeCubit>(create: (_) => sl<ThemeCubit>()),

        // ── Global Currencies State ───────────────────────────────────────
        BlocProvider<CurrencyCubit>(
          create: (_) => sl<CurrencyCubit>()..fetchCurrencies(),
        ),

        // ── Feature BLoCs / Cubits ────────────────────────────────────────
        BlocProvider<HomeCubit>(create: (_) => sl<HomeCubit>()),
        BlocProvider<WalletCubit>(create: (_) => sl<WalletCubit>()),
        BlocProvider<ActivityCubit>(create: (_) => sl<ActivityCubit>()),
        BlocProvider<TradersCubit>(create: (_) => sl<TradersCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, AppThemeVariant>(
        builder: (context, variant) {
          // variant.pair() → AppThemeVariantX extension (registry.dart)
          // Resolves the correct light + dark ThemeData for this design system family.
          final (ThemeData light, ThemeData dark) = variant.pair();

          return MaterialApp.router(
            title: 'El Dorado',
            debugShowCheckedModeBanner: false,
            theme: light,
            darkTheme: dark,
            themeMode: variant.themeMode,
            themeAnimationDuration: const Duration(milliseconds: 300),
            themeAnimationCurve: Curves.easeInOut,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
