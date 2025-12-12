import '../../core/models/injury_model.dart';
import '../repositories/injury_repository.dart';

class GetInjuryStatusUseCase {
  final InjuryRepository repository;

  GetInjuryStatusUseCase(this.repository);

  Future<InjuryModel> call() {
    return repository.getInjuryStatus();
  }
}
