import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class AppStateService extends ChangeNotifier {
  String _playerName = '';

  String get playerName => _playerName;

  void setPlayerName(String name) {
    if (_playerName != name) {
      _playerName = name;
      notifyListeners();
    }
  }

  void updatePlayerName(String name) {
    setPlayerName(name);
  }
}

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<AppStateService>(AppStateService());
}

AppStateService getAppStateService() {
  if (getIt.isRegistered<AppStateService>()) {
    return getIt.get<AppStateService>();
  } else {
    print('Ошибка: AppStateService не зарегистрирован в GetIt!');
    setupServiceLocator();
    return getIt.get<AppStateService>();
  }
}
