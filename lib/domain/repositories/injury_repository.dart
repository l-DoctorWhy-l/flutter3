import '../../core/models/injury_model.dart';

abstract class InjuryRepository {
  Future<InjuryModel> getInjuryStatus();
  Future<List<InjuryModel>> getInjuryHistory();
  Future<void> setInjuryStatus(bool isInjured);
}
