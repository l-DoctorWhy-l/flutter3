import '../../../core/models/player_model.dart';
import 'player_dto.dart';

extension PlayerDtoMapper on PlayerDto {
  PlayerModel toModel() {
    return PlayerModel(
      name: name,
      number: number,
      password: password,
    );
  }
}

extension PlayerModelMapper on PlayerModel {
  PlayerDto toDto() {
    return PlayerDto(
      name: name,
      number: number,
      password: password,
    );
  }
}
