import '../../../core/models/injury_model.dart';
import 'injury_dto.dart';

extension InjuryDtoMapper on InjuryDto {
  InjuryModel toModel() {
    return InjuryModel(
      isInjured: isInjured,
      timestamp: timestamp,
    );
  }
}

extension InjuryModelMapper on InjuryModel {
  InjuryDto toDto() {
    return InjuryDto(
      isInjured: isInjured,
      timestamp: timestamp,
    );
  }
}
