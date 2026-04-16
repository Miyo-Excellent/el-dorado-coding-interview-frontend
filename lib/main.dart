import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/di/injection_container.dart';
import 'infrastructure/router/app_router.dart';
import 'infrastructure/storage/hive_storage.dart';
import 'infrastructure/ui/theme/app_theme.dart';
import 'infrastructure/data/cubits/theme/theme_cubit.dart';
import 'infrastructure/data/blocs/home/exchange_bloc.dart';
import 'infrastructure/data/cubits/wallet/wallet_cubit.dart';
import 'infrastructure/data/cubits/activity/activity_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
/// Uses [BlocBuilder] on [ThemeCubit] to reactively switch between
/// dark and light themes.
class ElDoradoApp extends StatelessWidget {
  const ElDoradoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // ── Global Theme State ────────────────────────────────────────────
        BlocProvider<ThemeCubit>(create: (_) => sl<ThemeCubit>()),

        // ── Feature BLoCs / Cubits ────────────────────────────────────────
        BlocProvider<ExchangeBloc>(create: (_) => sl<ExchangeBloc>()),
        BlocProvider<WalletCubit>(create: (_) => sl<WalletCubit>()),
        BlocProvider<ActivityCubit>(create: (_) => sl<ActivityCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'El Dorado',
            debugShowCheckedModeBanner: false,
            theme: buildLightTheme(),
            darkTheme: buildDarkTheme(),
            themeMode: themeMode,
            themeAnimationDuration: Duration.zero,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
