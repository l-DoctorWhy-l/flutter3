import '../../../core/models/point_model.dart';
import 'point_dto.dart';

extension PointDtoMapper on PointDto {
  PointModel toModel() {
    return PointModel(
      value: value,
      timestamp: timestamp,
    );
  }
}

extension PointModelMapper on PointModel {
  PointDto toDto() {
    return PointDto(
      value: value,
      timestamp: timestamp,
    );
  }
}
