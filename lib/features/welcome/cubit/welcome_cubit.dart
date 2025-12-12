import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_player_profile_usecase.dart';
import '../../../domain/usecases/save_player_name_usecase.dart';
import '../../../shared/service_locator.dart';

class WelcomeState {
  final String playerName;
  final bool isValidating;
  final String? errorMessage;

  const WelcomeState({
    this.playerName = '',
    this.isValidating = false,
    this.errorMessage,
  });

  WelcomeState copyWith({
    String? playerName,
    bool? isValidating,
    String? errorMessage,
  }) {
    return WelcomeState(
      playerName: playerName ?? this.playerName,
      isValidating: isValidating ?? this.isValidating,
      errorMessage: errorMessage,
    );
  }

  bool get isValid => playerName.trim().length >= 2 && errorMessage == null;
}

class WelcomeCubit extends Cubit<WelcomeState> {
  final GetPlayerProfileUseCase getPlayerProfile;
  final SavePlayerNameUseCase savePlayerName;

  WelcomeCubit({
    GetPlayerProfileUseCase? getPlayerProfile,
    SavePlayerNameUseCase? savePlayerName,
  }) : 
    this.getPlayerProfile = getPlayerProfile ?? getIt<GetPlayerProfileUseCase>(),
    this.savePlayerName = savePlayerName ?? getIt<SavePlayerNameUseCase>(),
    super(const WelcomeState()) {
      _loadName();
    }

  Future<void> _loadName() async {
    final profile = await getPlayerProfile();
    if (profile.name.isNotEmpty) {
      emit(state.copyWith(playerName: profile.name));
    }
  }

  void updatePlayerName(String name) {
    final trimmedName = name.trim();
    String? errorMessage;

    if (trimmedName.isEmpty) {
      errorMessage = 'Пожалуйста, введите имя';
    } else if (trimmedName.length < 2) {
      errorMessage = 'Имя должно содержать минимум 2 символа';
    }

    emit(state.copyWith(
      playerName: name,
      errorMessage: errorMessage,
    ));

    // Save if valid, fire and forget to avoid blocking UI typing
    if (errorMessage == null) {
      savePlayerName(name);
    }
  }

  Future<void> validateAndNavigate() async {
    if (state.isValid) {
      await savePlayerName(state.playerName);
      emit(state.copyWith(isValidating: true));
    } else {
      // Показываем ошибку, если валидация не прошла
      final trimmedName = state.playerName.trim();
      String? errorMessage;
      if (trimmedName.isEmpty) {
        errorMessage = 'Пожалуйста, введите имя';
      } else if (trimmedName.length < 2) {
        errorMessage = 'Имя должно содержать минимум 2 символа';
      }
      emit(state.copyWith(errorMessage: errorMessage));
    }
  }

  void resetValidation() {
    emit(state.copyWith(
      isValidating: false,
      errorMessage: null,
    ));
  }
}
