import 'package:flutter_bloc/flutter_bloc.dart';

class NumberState {
  final int playerNumber;

  const NumberState({
    this.playerNumber = 22,
  });

  NumberState copyWith({
    int? playerNumber,
  }) {
    return NumberState(
      playerNumber: playerNumber ?? this.playerNumber,
    );
  }
}

class NumberCubit extends Cubit<NumberState> {
  NumberCubit() : super(const NumberState());

  void changeNumber(int change) {
    int newNumber = state.playerNumber + change;

    if (newNumber < 0) {
      newNumber = 0;
    } else if (newNumber > 99) {
      newNumber = 99;
    }

    emit(state.copyWith(playerNumber: newNumber));
  }

  void setNumber(int number) {
    int newNumber = number;
    
    if (newNumber < 0) {
      newNumber = 0;
    } else if (newNumber > 99) {
      newNumber = 99;
    }

    emit(state.copyWith(playerNumber: newNumber));
  }
}

