import 'package:shared_preferences/shared_preferences.dart';
import 'settings_dto.dart';

class SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _themeModeKey = 'theme_mode';

  SettingsLocalDataSource(this.sharedPreferences);

  Future<SettingsDto> getSettings() async {
    final themeIndex = sharedPreferences.getInt(_themeModeKey) ?? 2;
    return SettingsDto(themeModeIndex: themeIndex);
  }

  Future<void> saveThemeMode(int modeIndex) async {
    await sharedPreferences.setInt(_themeModeKey, modeIndex);
  }
}
