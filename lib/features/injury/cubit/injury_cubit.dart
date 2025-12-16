import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/injury_model.dart';
import '../../../domain/usecases/get_injury_status_usecase.dart';
import '../../../domain/usecases/get_injury_history_usecase.dart';
import '../../../domain/usecases/set_injury_status_usecase.dart';
import '../../../shared/service_locator.dart';

class InjuryState {
  final bool isInjured;
  final List<InjuryModel> injuryHistory;

  const InjuryState({
    this.isInjured = false,
    this.injuryHistory = const [],
  });

  InjuryState copyWith({
    bool? isInjured,
    List<InjuryModel>? injuryHistory,
  }) {
    return InjuryState(
      isInjured: isInjured ?? this.isInjured,
      injuryHistory: injuryHistory ?? this.injuryHistory,
    );
  }
}

class InjuryCubit extends Cubit<InjuryState> {
  final GetInjuryStatusUseCase getInjuryStatus;
  final GetInjuryHistoryUseCase getInjuryHistory;
  final SetInjuryStatusUseCase setInjuryStatus;

  InjuryCubit({
    GetInjuryStatusUseCase? getInjuryStatus,
    GetInjuryHistoryUseCase? getInjuryHistory,
    SetInjuryStatusUseCase? setInjuryStatus,
  }) : 
    this.getInjuryStatus = getInjuryStatus ?? getIt<GetInjuryStatusUseCase>(),
    this.getInjuryHistory = getInjuryHistory ?? getIt<GetInjuryHistoryUseCase>(),
    this.setInjuryStatus = setInjuryStatus ?? getIt<SetInjuryStatusUseCase>(),
    super(const InjuryState()) {
      _loadStatus();
    }

  Future<void> _loadStatus() async {
    final status = await getInjuryStatus();
    final history = await getInjuryHistory();
    
    emit(state.copyWith(
      isInjured: status.isInjured,
      injuryHistory: history,
    ));
  }

  Future<void> toggleInjuryStatus() async {
    final newStatus = !state.isInjured;
    
    await setInjuryStatus(newStatus);

    final newHistory = List<InjuryModel>.from(state.injuryHistory);
    newHistory.add(
      InjuryModel(
        isInjured: newStatus,
        timestamp: DateTime.now(),
      ),
    );

    emit(state.copyWith(
      isInjured: newStatus,
      injuryHistory: newHistory,
    ));
  }

  void removeLastInjuryRecord() {
    if (state.injuryHistory.isEmpty) return;

    final newHistory = List<InjuryModel>.from(state.injuryHistory);
    newHistory.removeLast();

    final newStatus = newHistory.isEmpty 
        ? false 
        : newHistory.last.isInjured;
    
    // Note: We are not persisting the removal of history or reversion of status here 
    // because our simplified repo only has setInjuryStatus. 
    // To be fully correct we should probably update the repo with newStatus.
    setInjuryStatus(newStatus);

    emit(state.copyWith(
      isInjured: newStatus,
      injuryHistory: newHistory,
    ));
  }
}
