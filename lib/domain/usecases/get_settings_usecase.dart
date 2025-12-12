import '../../core/models/settings_model.dart';
import '../repositories/settings_repository.dart';

class GetSettingsUseCase {
  final SettingsRepository repository;

  GetSettingsUseCase(this.repository);

  Future<SettingsModel> call() {
    return repository.getSettings();
  }
}
