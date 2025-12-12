import '../../core/models/settings_model.dart';
import '../repositories/settings_repository.dart';

class SaveThemeModeUseCase {
  final SettingsRepository repository;

  SaveThemeModeUseCase(this.repository);

  Future<void> call(AppThemeMode mode) {
    return repository.saveThemeMode(mode);
  }
}
