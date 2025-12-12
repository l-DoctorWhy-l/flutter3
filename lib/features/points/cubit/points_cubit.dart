import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/point_model.dart';
import '../../../domain/usecases/get_points_history_usecase.dart';
import '../../../domain/usecases/add_points_usecase.dart';
import '../../../domain/usecases/remove_last_points_usecase.dart';
import '../../../shared/service_locator.dart';

class PointsState {
  final int totalPoints;
  final List<PointModel> pointsHistory;

  const PointsState({
    this.totalPoints = 0,
    this.pointsHistory = const [],
  });

  PointsState copyWith({
    int? totalPoints,
    List<PointModel>? pointsHistory,
  }) {
    return PointsState(
      totalPoints: totalPoints ?? this.totalPoints,
      pointsHistory: pointsHistory ?? this.pointsHistory,
    );
  }
}

class PointsCubit extends Cubit<PointsState> {
  final GetPointsHistoryUseCase getPointsHistory;
  final AddPointsUseCase addPointsUseCase;
  final RemoveLastPointsUseCase removeLastPointsUseCase;

  PointsCubit({
    GetPointsHistoryUseCase? getPointsHistory,
    AddPointsUseCase? addPointsUseCase,
    RemoveLastPointsUseCase? removeLastPointsUseCase,
  }) : 
    this.getPointsHistory = getPointsHistory ?? getIt<GetPointsHistoryUseCase>(),
    this.addPointsUseCase = addPointsUseCase ?? getIt<AddPointsUseCase>(),
    this.removeLastPointsUseCase = removeLastPointsUseCase ?? getIt<RemoveLastPointsUseCase>(),
    super(const PointsState()) {
      _loadPoints();
    }

  Future<void> _loadPoints() async {
    final history = await getPointsHistory();
    int total = history.fold(0, (sum, element) => sum + element.value);
    
    emit(state.copyWith(
      totalPoints: total,
      pointsHistory: history,
    ));
  }

  Future<void> addPoints(int points) async {
    await addPointsUseCase(points);
    await _loadPoints();
  }

  Future<void> removeLastPoints() async {
    if (state.pointsHistory.isEmpty) return;
    
    await removeLastPointsUseCase();
    await _loadPoints();
  }
}
