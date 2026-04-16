import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/storage/hive_storage.dart';

/// Global Cubit that manages the app's theme mode.
///
/// Persists the selection to Hive local storage.
/// Dark theme is the default ("The Electric Alchemist").
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(_initialMode());

  static ThemeMode _initialMode() {
    final stored = HiveStorage.themeMode;
    return stored == 'light' ? ThemeMode.light : ThemeMode.dark;
  }

  /// Toggle between dark and light mode.
  void toggleTheme() {
    final newMode =
        state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(newMode);
    HiveStorage.setThemeMode(newMode == ThemeMode.light ? 'light' : 'dark');
  }

  /// Set a specific theme mode.
  void setTheme(ThemeMode mode) {
    emit(mode);
    HiveStorage.setThemeMode(mode == ThemeMode.light ? 'light' : 'dark');
  }

  /// Whether the current theme is dark.
  bool get isDark => state == ThemeMode.dark;

  /// Label for display in settings.
  String get label => isDark ? 'Dark' : 'Light';
}
