import '../../core/models/injury_model.dart';
import '../../domain/repositories/injury_repository.dart';
import '../datasources/injury/injury_local_datasource.dart';
import '../datasources/injury/injury_mapper.dart';

class InjuryRepositoryImpl implements InjuryRepository {
  final InjuryLocalDataSource dataSource;

  InjuryRepositoryImpl(this.dataSource);

  @override
  Future<InjuryModel> getInjuryStatus() async {
    final dto = await dataSource.getInjuryStatus();
    return dto.toModel();
  }

  @override
  Future<void> setInjuryStatus(bool isInjured) async {
    await dataSource.setInjuryStatus(isInjured);
  }
}
