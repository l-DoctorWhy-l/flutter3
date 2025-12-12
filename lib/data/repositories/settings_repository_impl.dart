import '../../core/models/settings_model.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings/settings_local_datasource.dart';
import '../datasources/settings/settings_mapper.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource dataSource;

  SettingsRepositoryImpl(this.dataSource);

  @override
  Future<SettingsModel> getSettings() async {
    final dto = await dataSource.getSettings();
    return dto.toModel();
  }

  @override
  Future<void> saveThemeMode(AppThemeMode mode) async {
    await dataSource.saveThemeMode(mode.index);
  }
}
