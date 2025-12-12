import 'injury_dto.dart';

class InjuryLocalDataSource {
  InjuryDto _injuryStatus = InjuryDto(isInjured: false, timestamp: DateTime.now());

  Future<InjuryDto> getInjuryStatus() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _injuryStatus;
  }

  Future<void> setInjuryStatus(bool isInjured) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _injuryStatus = InjuryDto(isInjured: isInjured, timestamp: DateTime.now());
  }
}
