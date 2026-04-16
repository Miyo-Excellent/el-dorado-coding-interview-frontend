import 'package:flutter/material.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const ElDoradoApp());
}

/// Root application widget.
///
/// Uses [MaterialApp.router] with [GoRouter] for declarative URL-based
/// navigation, and [buildAppTheme] for "The Electric Alchemist" design system.
class ElDoradoApp extends StatelessWidget {
  const ElDoradoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'El Dorado',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routerConfig: appRouter,
    );
  }
}
