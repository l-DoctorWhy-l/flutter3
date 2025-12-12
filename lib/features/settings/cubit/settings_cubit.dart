import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/settings_model.dart';
import '../../../domain/usecases/get_settings_usecase.dart';
import '../../../domain/usecases/save_theme_mode_usecase.dart';
import '../../../shared/service_locator.dart';

class SettingsState {
  final ThemeMode themeMode;

  const SettingsState({
    this.themeMode = ThemeMode.system,
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  final GetSettingsUseCase getSettings;
  final SaveThemeModeUseCase saveThemeMode;

  SettingsCubit({
    GetSettingsUseCase? getSettings,
    SaveThemeModeUseCase? saveThemeMode,
  }) : 
    this.getSettings = getSettings ?? getIt<GetSettingsUseCase>(),
    this.saveThemeMode = saveThemeMode ?? getIt<SaveThemeModeUseCase>(),
    super(const SettingsState()) {
      _loadSettings();
    }

  Future<void> _loadSettings() async {
    final settings = await getSettings();
    emit(state.copyWith(themeMode: _mapAppThemeToFlutterTheme(settings.themeMode)));
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await saveThemeMode(_mapFlutterThemeToAppTheme(themeMode));
    emit(state.copyWith(themeMode: themeMode));
  }

  Future<void> toggleTheme() async {
    final newThemeMode = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    
    await saveThemeMode(_mapFlutterThemeToAppTheme(newThemeMode));
    emit(state.copyWith(themeMode: newThemeMode));
  }

  ThemeMode _mapAppThemeToFlutterTheme(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  AppThemeMode _mapFlutterThemeToAppTheme(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return AppThemeMode.light;
      case ThemeMode.dark:
        return AppThemeMode.dark;
      case ThemeMode.system:
        return AppThemeMode.system;
    }
  }
}
