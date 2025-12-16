import '../../../core/helpers/secure_storage_helper.dart';
import 'player_dto.dart';

class PlayerLocalDataSource {
  static const _kNameKey = 'player_name';
  static const _kPasswordKey = 'player_password';
  
  int _number = 22;

  Future<PlayerDto> getPlayerProfile() async {
    final name = await SecureStorageHelper.instance.read(_kNameKey);
    final password = await SecureStorageHelper.instance.read(_kPasswordKey);
    return PlayerDto(name: name ?? '', number: _number, password: password);
  }

  Future<void> savePlayerName(String name) async {
    await SecureStorageHelper.instance.save(_kNameKey, name);
  }

  Future<void> savePlayerPassword(String password) async {
    await SecureStorageHelper.instance.save(_kPasswordKey, password);
  }

  Future<void> savePlayerNumber(int number) async {
    _number = number;
  }
}
