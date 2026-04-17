import 'package:get_it/get_it.dart';

import 'package:el_dorado_coding_interview_frontend/infrastructure/network/dio_client.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/network/datasources/recommendation_remote_datasource.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/repositories_impl/recommendation_repository_impl.dart';
import 'package:el_dorado_coding_interview_frontend/domain/repositories/recommendation_repository.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/get_recommendations.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/calculate_conversion.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/validate_offer_limits.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/get_wallet_data.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/get_activity_data.dart';
import 'package:el_dorado_coding_interview_frontend/domain/repositories/wallet_repository.dart';
import 'package:el_dorado_coding_interview_frontend/domain/repositories/activity_repository.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/repositories_impl/wallet_repository_impl.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/repositories_impl/activity_repository_impl.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/network/datasources/wallet_mock_remote_datasource.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/network/datasources/activity_mock_remote_datasource.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/blocs/exchange/exchange_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/home/home_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/wallet/wallet_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/activity/activity_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/theme/theme_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/traders/traders_cubit.dart';

import 'package:el_dorado_coding_interview_frontend/infrastructure/network/datasources/currency_remote_datasource.dart';
import 'package:el_dorado_coding_interview_frontend/domain/repositories/currency_repository.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/repositories_impl/currency_repository_impl.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/get_currencies.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/currency/currency_cubit.dart';

import 'package:el_dorado_coding_interview_frontend/infrastructure/network/datasources/payment_method_remote_datasource.dart';
import 'package:el_dorado_coding_interview_frontend/domain/repositories/payment_method_repository.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/repositories_impl/payment_method_repository_impl.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/get_payment_methods.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/payment_method/payment_method_cubit.dart';

/// Global service locator instance.
final GetIt sl = GetIt.instance;

/// Configure all dependency registrations.
///
/// Call once at app startup **after** [HiveStorage.init()].
void configureDependencies() {
  // ── Core ──────────────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => DioClient.instance);

  // ── Data Sources ──────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => RecommendationRemoteDataSource(dio: sl()));
  sl.registerLazySingleton(() => CurrencyRemoteDataSource(dio: sl()));
  sl.registerLazySingleton(() => PaymentMethodRemoteDataSource(dio: sl()));
  sl.registerLazySingleton(() => const WalletMockRemoteDataSource());
  sl.registerLazySingleton(() => const ActivityMockRemoteDataSource());

  // ── Repositories ──────────────────────────────────────────────────────────
  sl.registerLazySingleton<RecommendationRepository>(
    () => RecommendationRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<CurrencyRepository>(
    () => CurrencyRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<PaymentMethodRepository>(
    () => PaymentMethodRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<WalletRepository>(() => WalletRepositoryImpl(sl()));
  sl.registerLazySingleton<ActivityRepository>(
    () => ActivityRepositoryImpl(sl()),
  );

  // ── Use Cases ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => GetRecommendations(repository: sl()));
  sl.registerLazySingleton(() => GetCurrenciesUseCase(sl()));
  sl.registerLazySingleton(() => GetPaymentMethodsUseCase(sl()));
  sl.registerLazySingleton(() => const CalculateConversion());
  sl.registerLazySingleton(() => const ValidateOfferLimits());
  sl.registerLazySingleton(() => GetWalletData(sl()));
  sl.registerLazySingleton(() => GetActivityData(sl()));

  // ── BLoCs / Cubits ────────────────────────────────────────────────────────
  // ExchangeBloc is a singleton that constantly queries API every 10s.
  sl.registerLazySingleton(() => ExchangeBloc(getRecommendations: sl()));

  // Global Currency Cubit
  sl.registerLazySingleton(() => CurrencyCubit(getCurrenciesUseCase: sl()));

  // Global Payment Method Cubit
  sl.registerLazySingleton(
    () => PaymentMethodCubit(getPaymentMethodsUseCase: sl()),
  );

  // HomeCubit acts as the ViewModel consuming ExchangeBloc.
  sl.registerFactory(
    () => HomeCubit(
      exchangeBloc: sl(),
      calculateConversion: sl(),
      validateOfferLimits: sl(),
    ),
  );

  sl.registerFactory(() => WalletCubit(getWalletData: sl()));
  sl.registerFactory(() => ActivityCubit(getActivityData: sl()));
  sl.registerFactory(() => TradersCubit());

  // ThemeCubit is a singleton — shared across the entire app.
  sl.registerLazySingleton(() => ThemeCubit());
}
