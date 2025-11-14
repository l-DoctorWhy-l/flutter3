import 'package:flutter_bloc/flutter_bloc.dart';

class PointsState {
  final int totalPoints;
  final List<int> pointsHistory;

  const PointsState({
    this.totalPoints = 0,
    this.pointsHistory = const [],
  });

  PointsState copyWith({
    int? totalPoints,
    List<int>? pointsHistory,
  }) {
    return PointsState(
      totalPoints: totalPoints ?? this.totalPoints,
      pointsHistory: pointsHistory ?? this.pointsHistory,
    );
  }
}

class PointsCubit extends Cubit<PointsState> {
  PointsCubit() : super(const PointsState());

  void addPoints(int points) {
    final newHistory = List<int>.from(state.pointsHistory);
    newHistory.add(points);

    emit(state.copyWith(
      totalPoints: state.totalPoints + points,
      pointsHistory: newHistory,
    ));
  }

  void removeLastPoints() {
    if (state.pointsHistory.isEmpty) return;

    final newHistory = List<int>.from(state.pointsHistory);
    final lastPoints = newHistory.removeLast();

    emit(state.copyWith(
      totalPoints: state.totalPoints - lastPoints,
      pointsHistory: newHistory,
    ));
  }
}

