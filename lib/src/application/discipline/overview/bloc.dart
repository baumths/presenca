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
        super(const DisciplinesOverviewState.initial()) {
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
      onError: (_, __) => const DisciplinesOverviewState.initial(),
      onData: (List<Discipline> disciplines) {
        if (disciplines.isEmpty) {
          return const DisciplinesOverviewState.initial();
        }

        return DisciplinesOverviewState.loadSuccess(
          disciplines: disciplines,
        );
      },
    );
  }
}
