import '../../core/models/assist_model.dart';
import '../repositories/assist_repository.dart';

class SaveAssistUseCase {
  final AssistRepository repository;

  SaveAssistUseCase(this.repository);

  Future<void> call(AssistModel assist) {
    return repository.saveAssist(assist);
  }
}


