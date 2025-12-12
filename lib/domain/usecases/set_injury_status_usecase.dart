import '../repositories/injury_repository.dart';

class SetInjuryStatusUseCase {
  final InjuryRepository repository;

  SetInjuryStatusUseCase(this.repository);

  Future<void> call(bool isInjured) {
    return repository.setInjuryStatus(isInjured);
  }
}
