import '../../core/models/settings_model.dart';

abstract class SettingsRepository {
  Future<SettingsModel> getSettings();
  Future<void> saveThemeMode(AppThemeMode mode);
}
