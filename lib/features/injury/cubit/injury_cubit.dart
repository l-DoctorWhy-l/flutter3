import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/injury_record.dart';

class InjuryState {
  final bool isInjured;
  final List<InjuryRecord> injuryHistory;

  const InjuryState({
    this.isInjured = false,
    this.injuryHistory = const [],
  });

  InjuryState copyWith({
    bool? isInjured,
    List<InjuryRecord>? injuryHistory,
  }) {
    return InjuryState(
      isInjured: isInjured ?? this.isInjured,
      injuryHistory: injuryHistory ?? this.injuryHistory,
    );
  }
}

class InjuryCubit extends Cubit<InjuryState> {
  InjuryCubit() : super(const InjuryState());

  void toggleInjuryStatus() {
    final newStatus = !state.isInjured;
    final newHistory = List<InjuryRecord>.from(state.injuryHistory);
    
    newHistory.add(
      InjuryRecord(
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

    final newHistory = List<InjuryRecord>.from(state.injuryHistory);
    newHistory.removeLast();

    final newStatus = newHistory.isEmpty 
        ? false 
        : newHistory.last.isInjured;

    emit(state.copyWith(
      isInjured: newStatus,
      injuryHistory: newHistory,
    ));
  }
}

