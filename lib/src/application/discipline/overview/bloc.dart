import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/discipline.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

class DisciplinesOverviewBloc
    extends Bloc<DisciplinesOverviewEvent, DisciplinesOverviewState> {
  DisciplinesOverviewBloc({
    required DisciplinesRepository disciplinesRepository,
  })  : _disciplinesRepository = disciplinesRepository,
        super(const DisciplinesOverviewState.loadInProgress()) {
    on<DisciplinesOverviewEvent>(_onEvent);
  }

  final DisciplinesRepository _disciplinesRepository;

  Future<void> _onEvent(
    DisciplinesOverviewEvent event,
    Emitter<DisciplinesOverviewState> emit,
  ) async {
    await event.map(
      started: (event) => _onStarted(event, emit),
    );
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<DisciplinesOverviewState> emit,
  ) async {
    await emit.forEach(
      _disciplinesRepository.watch(),
      onError: (_, __) {
        return const DisciplinesOverviewState.loadSuccess(
          disciplines: [],
        );
      },
      onData: (List<Discipline> disciplines) {
        return DisciplinesOverviewState.loadSuccess(
          disciplines: disciplines,
        );
      },
    );
  }
}
