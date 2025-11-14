import 'package:flutter_bloc/flutter_bloc.dart';

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
  WelcomeCubit() : super(const WelcomeState());

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

  void validateAndNavigate() {
    if (state.isValid) {
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

