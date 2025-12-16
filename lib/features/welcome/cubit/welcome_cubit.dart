import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_player_profile_usecase.dart';
import '../../../domain/usecases/save_player_name_usecase.dart';
import '../../../domain/usecases/save_player_password_usecase.dart';
import '../../../shared/service_locator.dart';

class WelcomeState {
  final String playerName;
  final String password;
  final bool isValidating;
  final String? errorMessage;
  final String? passwordError;

  const WelcomeState({
    this.playerName = '',
    this.password = '',
    this.isValidating = false,
    this.errorMessage,
    this.passwordError,
  });

  WelcomeState copyWith({
    String? playerName,
    String? password,
    bool? isValidating,
    String? errorMessage,
    String? passwordError,
  }) {
    return WelcomeState(
      playerName: playerName ?? this.playerName,
      password: password ?? this.password,
      isValidating: isValidating ?? this.isValidating,
      errorMessage: errorMessage,
      passwordError: passwordError,
    );
  }

  bool get isValid => 
    playerName.trim().length >= 2 && 
    errorMessage == null &&
    password.length >= 6 &&
    passwordError == null;
}

class WelcomeCubit extends Cubit<WelcomeState> {
  final GetPlayerProfileUseCase getPlayerProfile;
  final SavePlayerNameUseCase savePlayerName;
  final SavePlayerPasswordUseCase savePlayerPassword;

  WelcomeCubit({
    GetPlayerProfileUseCase? getPlayerProfile,
    SavePlayerNameUseCase? savePlayerName,
    SavePlayerPasswordUseCase? savePlayerPassword,
  }) : 
    this.getPlayerProfile = getPlayerProfile ?? getIt<GetPlayerProfileUseCase>(),
    this.savePlayerName = savePlayerName ?? getIt<SavePlayerNameUseCase>(),
    this.savePlayerPassword = savePlayerPassword ?? getIt<SavePlayerPasswordUseCase>(),
    super(const WelcomeState()) {
      _loadData();
    }

  Future<void> _loadData() async {
    final profile = await getPlayerProfile();
    emit(state.copyWith(
      playerName: profile.name,
      password: profile.password ?? '',
    ));
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
  }

  void updatePassword(String password) {
    String? passwordError;
    if (password.length < 6) {
      passwordError = 'Пароль должен быть не менее 6 символов';
    }

    emit(state.copyWith(
      password: password,
      passwordError: passwordError,
    ));
  }

  Future<void> validateAndNavigate() async {
    final nameValid = state.playerName.trim().length >= 2;
    final passwordValid = state.password.length >= 6;

    if (nameValid && passwordValid) {
      await savePlayerName(state.playerName);
      await savePlayerPassword(state.password);
      emit(state.copyWith(isValidating: true));
    } else {
      String? errorMessage;
      if (!nameValid) {
        final trimmedName = state.playerName.trim();
        if (trimmedName.isEmpty) {
          errorMessage = 'Пожалуйста, введите имя';
        } else {
          errorMessage = 'Имя должно содержать минимум 2 символа';
        }
      }

      String? passwordError;
      if (!passwordValid) {
        passwordError = 'Пароль должен быть не менее 6 символов';
      }

      emit(state.copyWith(
        errorMessage: errorMessage,
        passwordError: passwordError,
      ));
    }
  }

  void resetValidation() {
    emit(state.copyWith(
      isValidating: false,
      errorMessage: null,
      passwordError: null,
    ));
  }
}
