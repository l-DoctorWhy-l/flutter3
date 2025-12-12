import '../../core/models/assist_model.dart';
import '../../domain/repositories/assist_repository.dart';
import '../datasources/assists/assist_local_datasource.dart';
import '../datasources/assists/assist_mapper.dart';

class AssistRepositoryImpl implements AssistRepository {
  final AssistLocalDataSource dataSource;

  AssistRepositoryImpl(this.dataSource);

  @override
  Future<List<AssistModel>> getAssists() async {
    final dtos = await dataSource.getAssists();
    return dtos.map((dto) => dto.toModel()).toList();
  }

  @override
  Future<void> saveAssist(AssistModel assist) async {
    await dataSource.saveAssist(assist.toDto());
  }

  @override
  Future<void> deleteAssist(String id) async {
    await dataSource.deleteAssist(id);
  }
}
