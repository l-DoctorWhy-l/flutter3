import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/assist_model.dart';
import '../../../domain/usecases/get_assists_usecase.dart';
import '../../../domain/usecases/save_assist_usecase.dart';
import '../../../domain/usecases/delete_assist_usecase.dart';
import '../../../shared/service_locator.dart';

class AssistsState {
  final int assists;
  final List<AssistModel> assistsHistory;

  const AssistsState({
    this.assists = 0,
    this.assistsHistory = const [],
  });

  AssistsState copyWith({
    int? assists,
    List<AssistModel>? assistsHistory,
  }) {
    return AssistsState(
      assists: assists ?? this.assists,
      assistsHistory: assistsHistory ?? this.assistsHistory,
    );
  }
}

class AssistsCubit extends Cubit<AssistsState> {
  final GetAssistsUseCase getAssists;
  final SaveAssistUseCase saveAssist;
  final DeleteAssistUseCase deleteAssist;

  AssistsCubit({
    GetAssistsUseCase? getAssists,
    SaveAssistUseCase? saveAssist,
    DeleteAssistUseCase? deleteAssist,
  }) : 
    this.getAssists = getAssists ?? getIt<GetAssistsUseCase>(),
    this.saveAssist = saveAssist ?? getIt<SaveAssistUseCase>(),
    this.deleteAssist = deleteAssist ?? getIt<DeleteAssistUseCase>(),
    super(const AssistsState()) {
      _loadAssists();
    }

  Future<void> _loadAssists() async {
    final history = await getAssists();
    emit(state.copyWith(
      assists: history.length,
      assistsHistory: history,
    ));
  }

  Future<void> addAssist() async {
    final assist = AssistModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      timestamp: DateTime.now(),
    );

    await saveAssist(assist);
    await _loadAssists();
  }

  Future<void> removeAssist(int index) async {
    if (state.assistsHistory.isEmpty || index < 0 || index >= state.assistsHistory.length) {
      return;
    }

    final assist = state.assistsHistory[index];
    await deleteAssist(assist.id);
    await _loadAssists();
  }

  Future<void> removeLastAssist() async {
    if (state.assistsHistory.isEmpty) return;
    
    final assist = state.assistsHistory.last;
    await deleteAssist(assist.id);
    await _loadAssists();
  }
}
