import '../../core/models/assist_model.dart';
import '../repositories/assist_repository.dart';

class GetAssistsUseCase {
  final AssistRepository repository;

  GetAssistsUseCase(this.repository);

  Future<List<AssistModel>> call() {
    return repository.getAssists();
  }
}


