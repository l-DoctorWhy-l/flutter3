import '../../core/models/injury_model.dart';

abstract class InjuryRepository {
  Future<InjuryModel> getInjuryStatus();
  Future<void> setInjuryStatus(bool isInjured);
}
