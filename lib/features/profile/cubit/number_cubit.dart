import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_player_profile_usecase.dart';
import '../../../domain/usecases/save_player_number_usecase.dart';
import '../../../shared/service_locator.dart';

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
  final GetPlayerProfileUseCase getPlayerProfile;
  final SavePlayerNumberUseCase savePlayerNumber;

  NumberCubit({
    GetPlayerProfileUseCase? getPlayerProfile,
    SavePlayerNumberUseCase? savePlayerNumber,
  }) : 
    this.getPlayerProfile = getPlayerProfile ?? getIt<GetPlayerProfileUseCase>(),
    this.savePlayerNumber = savePlayerNumber ?? getIt<SavePlayerNumberUseCase>(),
    super(const NumberState()) {
      _loadNumber();
    }

  Future<void> _loadNumber() async {
    final profile = await getPlayerProfile();
    emit(state.copyWith(playerNumber: profile.number));
  }

  Future<void> changeNumber(int change) async {
    int newNumber = state.playerNumber + change;

    if (newNumber < 0) {
      newNumber = 0;
    } else if (newNumber > 99) {
      newNumber = 99;
    }

    await savePlayerNumber(newNumber);
    emit(state.copyWith(playerNumber: newNumber));
  }

  Future<void> setNumber(int number) async {
    int newNumber = number;
    
    if (newNumber < 0) {
      newNumber = 0;
    } else if (newNumber > 99) {
      newNumber = 99;
    }

    await savePlayerNumber(newNumber);
    emit(state.copyWith(playerNumber: newNumber));
  }
}
