import 'settings_dto.dart';

class SettingsLocalDataSource {
  SettingsDto _settings = SettingsDto(themeModeIndex: 2); // Default to system

  Future<SettingsDto> getSettings() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _settings;
  }

  Future<void> saveThemeMode(int modeIndex) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _settings = SettingsDto(themeModeIndex: modeIndex);
  }
}
