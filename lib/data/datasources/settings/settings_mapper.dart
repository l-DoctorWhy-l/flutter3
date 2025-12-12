import '../../../core/models/settings_model.dart';
import 'settings_dto.dart';

extension SettingsDtoMapper on SettingsDto {
  SettingsModel toModel() {
    return SettingsModel(
      themeMode: AppThemeMode.values[themeModeIndex],
    );
  }
}

extension SettingsModelMapper on SettingsModel {
  SettingsDto toDto() {
    return SettingsDto(
      themeModeIndex: themeMode.index,
    );
  }
}
