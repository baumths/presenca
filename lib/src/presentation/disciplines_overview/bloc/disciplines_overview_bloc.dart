import 'dart:async' show StreamSubscription;

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/discipline.dart';

part 'disciplines_overview_bloc.freezed.dart';
part 'disciplines_overview_event.dart';
part 'disciplines_overview_state.dart';

class DisciplineOverviewBloc
    extends Bloc<DisciplinesOverviewEvent, DisciplinesOverviewState> {
  DisciplineOverviewBloc({
    required DisciplinesRepository disciplinesRepository,
  })  : _disciplinesRepository = disciplinesRepository,
        super(const DisciplinesOverviewState.initial()) {
    on<DisciplinesOverviewEvent>(_onEvent);
  }

  final DisciplinesRepository _disciplinesRepository;

  StreamSubscription<String>? _streamSubscription;

  Future<void> _onEvent(
    DisciplinesOverviewEvent event,
    Emitter<DisciplinesOverviewState> emit,
  ) async {
    await event.map(
      initialized: _onInitialize,
      refreshed: (event) => _onRefreshed(event, emit),
    );
  }

  Future<void> _onInitialize(DisciplinesOverviewInitialized event) async {
    add(const DisciplinesOverviewEvent.refreshed());

    await _streamSubscription?.cancel();
    _streamSubscription = _disciplinesRepository.watch().listen((_) {
      add(const DisciplinesOverviewEvent.refreshed());
    });
  }

  Future<void> _onRefreshed(
    DisciplinesOverviewRefreshed event,
    Emitter<DisciplinesOverviewState> emit,
  ) async {
    emit(const DisciplinesOverviewState.loadInProgress());

    final disciplines = await _disciplinesRepository.findAll();

    // TODO(future): sort by creation date
    disciplines.sort((a, b) => a.name.compareTo(b.name));

    if (disciplines.isEmpty) {
      emit(const DisciplinesOverviewState.initial());
    } else {
      emit(DisciplinesOverviewState.loadSuccess(disciplines: disciplines));
    }
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    return super.close();
  }
}
