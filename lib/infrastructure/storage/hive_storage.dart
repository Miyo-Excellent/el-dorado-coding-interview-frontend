import 'package:hive_ce/hive_ce.dart';
import 'package:path_provider/path_provider.dart';

/// Manages Hive box initialization and provides typed access
/// to local storage boxes.
class HiveStorage {
  HiveStorage._();

  static const String _settingsBox = 'settings';
  static const String _cacheBox = 'cache';
  static const String _transactionsBox = 'transactions';
  static const String _profileBox = 'profile';
  static const String _banksBox = 'banks';

  // Keys
  static const String themeKey = 'theme_mode'; // 'dark' | 'light'
  static const String lastFiatCurrencyKey = 'last_fiat_currency';
  static const String lastAmountKey = 'last_amount';

  static bool _initialized = false;

  /// Initialize Hive with the app documents directory.
  static Future<void> init() async {
    if (_initialized) return;

    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    await Future.wait([
      Hive.openBox(_settingsBox),
      Hive.openBox(_cacheBox),
      Hive.openBox(_transactionsBox),
      Hive.openBox(_profileBox),
      Hive.openBox(_banksBox),
    ]);

    _initialized = true;
  }

  /// The settings box – stores user preferences (theme, language, etc.).
  static Box get settings => Hive.box(_settingsBox);

  /// The cache box – stores last API response for offline display.
  static Box get cache => Hive.box(_cacheBox);

  /// Simulated transactions box.
  static Box get transactions => Hive.box(_transactionsBox);

  /// Profile data box 
  static Box get profile => Hive.box(_profileBox);

  /// Bank accounts box
  static Box get banks => Hive.box(_banksBox);

  // ── Convenience getters / setters ──────────────────────────────────────────

  /// Current theme mode string: `'dark'` (default) or `'light'`.
  static String get themeMode =>
      settings.get(themeKey, defaultValue: 'dark') as String;

  static Future<void> setThemeMode(String mode) =>
      settings.put(themeKey, mode);

  /// Last selected fiat currency (default: `'COP'`).
  static String get lastFiatCurrency =>
      settings.get(lastFiatCurrencyKey, defaultValue: 'COP') as String;

  static Future<void> setLastFiatCurrency(String currency) =>
      settings.put(lastFiatCurrencyKey, currency);

  /// Last entered amount (default: `'50'`).
  static String get lastAmount =>
      settings.get(lastAmountKey, defaultValue: '50') as String;

  static Future<void> setLastAmount(String amount) =>
      settings.put(lastAmountKey, amount);
}
