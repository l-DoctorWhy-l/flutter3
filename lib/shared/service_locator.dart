import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Data Sources
import '../data/datasources/assists/assist_local_datasource.dart';
import '../data/datasources/injury/injury_local_datasource.dart';
import '../data/datasources/points/points_local_datasource.dart';
import '../data/datasources/player/player_local_datasource.dart';
import '../data/datasources/settings/settings_local_datasource.dart';

// Repositories
import '../domain/repositories/assist_repository.dart';
import '../data/repositories/assist_repository_impl.dart';
import '../domain/repositories/injury_repository.dart';
import '../data/repositories/injury_repository_impl.dart';
import '../domain/repositories/points_repository.dart';
import '../data/repositories/points_repository_impl.dart';
import '../domain/repositories/player_repository.dart';
import '../data/repositories/player_repository_impl.dart';
import '../domain/repositories/settings_repository.dart';
import '../data/repositories/settings_repository_impl.dart';

// Use Cases
import '../domain/usecases/get_assists_usecase.dart';
import '../domain/usecases/save_assist_usecase.dart';
import '../domain/usecases/delete_assist_usecase.dart';
import '../domain/usecases/get_injury_status_usecase.dart';
import '../domain/usecases/get_injury_history_usecase.dart';
import '../domain/usecases/set_injury_status_usecase.dart';
import '../domain/usecases/get_points_history_usecase.dart';
import '../domain/usecases/add_points_usecase.dart';
import '../domain/usecases/remove_last_points_usecase.dart';
import '../domain/usecases/get_player_profile_usecase.dart';
import '../domain/usecases/save_player_name_usecase.dart';
import '../domain/usecases/save_player_number_usecase.dart';
import '../domain/usecases/save_player_password_usecase.dart';
import '../domain/usecases/get_settings_usecase.dart';
import '../domain/usecases/save_theme_mode_usecase.dart';

final getIt = GetIt.instance;

void setupServiceLocator(SharedPreferences prefs) {
  // External
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Data Sources
  getIt.registerLazySingleton(() => AssistLocalDataSource());
  getIt.registerLazySingleton(() => InjuryLocalDataSource());
  getIt.registerLazySingleton(() => PointsLocalDataSource());
  getIt.registerLazySingleton(() => PlayerLocalDataSource());
  getIt.registerLazySingleton(() => SettingsLocalDataSource(getIt()));

  // Repositories
  getIt.registerLazySingleton<AssistRepository>(
    () => AssistRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<InjuryRepository>(
    () => InjuryRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<PointsRepository>(
    () => PointsRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<PlayerRepository>(
    () => PlayerRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt()),
  );

  // Use Cases
  // Assists
  getIt.registerLazySingleton(() => GetAssistsUseCase(getIt()));
  getIt.registerLazySingleton(() => SaveAssistUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteAssistUseCase(getIt()));
  
  // Injury
  getIt.registerLazySingleton(() => GetInjuryStatusUseCase(getIt()));
  getIt.registerLazySingleton(() => GetInjuryHistoryUseCase(getIt()));
  getIt.registerLazySingleton(() => SetInjuryStatusUseCase(getIt()));
  
  // Points
  getIt.registerLazySingleton(() => GetPointsHistoryUseCase(getIt()));
  getIt.registerLazySingleton(() => AddPointsUseCase(getIt()));
  getIt.registerLazySingleton(() => RemoveLastPointsUseCase(getIt()));
  
  // Player
  getIt.registerLazySingleton(() => GetPlayerProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => SavePlayerNameUseCase(getIt()));
  getIt.registerLazySingleton(() => SavePlayerPasswordUseCase(getIt()));
  getIt.registerLazySingleton(() => SavePlayerNumberUseCase(getIt()));
  
  // Settings
  getIt.registerLazySingleton(() => GetSettingsUseCase(getIt()));
  getIt.registerLazySingleton(() => SaveThemeModeUseCase(getIt()));
}
