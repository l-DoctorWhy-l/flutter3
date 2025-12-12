import '../../../core/models/assist_model.dart';
import 'assist_dto.dart';

extension AssistDtoMapper on AssistDto {
  AssistModel toModel() {
    return AssistModel(
      id: id,
      timestamp: timestamp,
    );
  }
}

extension AssistModelMapper on AssistModel {
  AssistDto toDto() {
    return AssistDto(
      id: id,
      timestamp: timestamp,
    );
  }
}

