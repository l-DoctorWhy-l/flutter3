import '../repositories/injury_repository.dart';
import '../../core/models/injury_model.dart';

class GetInjuryHistoryUseCase {
  final InjuryRepository repository;

  GetInjuryHistoryUseCase(this.repository);

  Future<List<InjuryModel>> call() async {
    return repository.getInjuryHistory();
  }
}


