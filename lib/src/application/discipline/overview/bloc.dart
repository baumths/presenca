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
          disciplines: _sortDisciplines(disciplines),
        );
      },
    );
  }

  /// This sorts all disciplines by [Discipline.name] then moves all archived
  /// disciplines to the end of the list.
  List<Discipline> _sortDisciplines(List<Discipline> disciplines) {
    disciplines.sort((a, b) => a.name.compareTo(b.name));

    final unarchivedDisciplines = <Discipline>[];
    final archivedDisciplines = <Discipline>[];

    for (final discipline in disciplines) {
      if (discipline.isArchived) {
        archivedDisciplines.add(discipline);
      } else {
        unarchivedDisciplines.add(discipline);
      }
    }
    return [...unarchivedDisciplines, ...archivedDisciplines];
  }
}
