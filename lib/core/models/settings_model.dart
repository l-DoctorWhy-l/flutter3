enum AppThemeMode { light, dark, system }

class SettingsModel {
  final AppThemeMode themeMode;

  SettingsModel({
    required this.themeMode,
  });
}
