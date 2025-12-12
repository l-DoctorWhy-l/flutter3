import 'player_dto.dart';

class PlayerLocalDataSource {
  PlayerDto _player = PlayerDto(name: '', number: 22);

  Future<PlayerDto> getPlayerProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _player;
  }

  Future<void> savePlayerName(String name) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _player = _player.copyWith(name: name);
  }

  Future<void> savePlayerNumber(int number) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _player = _player.copyWith(number: number);
  }
}
