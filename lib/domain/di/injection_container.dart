import 'package:get_it/get_it.dart';

import 'package:el_dorado_coding_interview_frontend/infrastructure/network/dio_client.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/network/datasources/recommendation_remote_datasource.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/repositories_impl/recommendation_repository_impl.dart';
import 'package:el_dorado_coding_interview_frontend/domain/repositories/recommendation_repository.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/get_recommendations.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/blocs/home/exchange_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/wallet/wallet_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/activity/activity_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/theme/theme_cubit.dart';

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

  // ── Repositories ──────────────────────────────────────────────────────────
  sl.registerLazySingleton<RecommendationRepository>(
    () => RecommendationRepositoryImpl(remoteDataSource: sl()),
  );

  // ── Use Cases ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => GetRecommendations(repository: sl()));

  // ── BLoCs / Cubits ────────────────────────────────────────────────────────
  // Factory = new instance per screen / per widget that needs it.
  sl.registerFactory(() => ExchangeBloc(getRecommendations: sl()));

  sl.registerFactory(() => WalletCubit());
  sl.registerFactory(() => ActivityCubit());

  // ThemeCubit is a singleton — shared across the entire app.
  sl.registerLazySingleton(() => ThemeCubit());
}
