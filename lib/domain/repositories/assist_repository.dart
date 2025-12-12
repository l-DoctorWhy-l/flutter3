import '../../core/models/assist_model.dart';

abstract class AssistRepository {
  Future<List<AssistModel>> getAssists();
  Future<void> saveAssist(AssistModel assist);
  Future<void> deleteAssist(String id);
}
