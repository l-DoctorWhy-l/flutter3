import '../repositories/assist_repository.dart';

class DeleteAssistUseCase {
  final AssistRepository repository;

  DeleteAssistUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteAssist(id);
  }
}

