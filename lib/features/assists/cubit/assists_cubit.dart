import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/assist_record.dart';

class AssistsState {
  final int assists;
  final List<AssistRecord> assistsHistory;

  const AssistsState({
    this.assists = 0,
    this.assistsHistory = const [],
  });

  AssistsState copyWith({
    int? assists,
    List<AssistRecord>? assistsHistory,
  }) {
    return AssistsState(
      assists: assists ?? this.assists,
      assistsHistory: assistsHistory ?? this.assistsHistory,
    );
  }
}

class AssistsCubit extends Cubit<AssistsState> {
  AssistsCubit() : super(const AssistsState());

  void addAssist() {
    final newHistory = List<AssistRecord>.from(state.assistsHistory);
    
    newHistory.add(
      AssistRecord(
        timestamp: DateTime.now(),
        key: ValueKey(DateTime.now().millisecondsSinceEpoch),
      ),
    );

    emit(state.copyWith(
      assists: newHistory.length,
      assistsHistory: newHistory,
    ));
  }

  void removeAssist(int index) {
    if (state.assistsHistory.isEmpty || index < 0 || index >= state.assistsHistory.length) {
      return;
    }

    final newHistory = List<AssistRecord>.from(state.assistsHistory);
    newHistory.removeAt(index);

    emit(state.copyWith(
      assists: newHistory.length,
      assistsHistory: newHistory,
    ));
  }

  void removeLastAssist() {
    if (state.assistsHistory.isEmpty) return;

    final newHistory = List<AssistRecord>.from(state.assistsHistory);
    newHistory.removeLast();

    emit(state.copyWith(
      assists: newHistory.length,
      assistsHistory: newHistory,
    ));
  }
}

