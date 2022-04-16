import 'dart:async' show StreamSubscription;

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/discipline.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

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
      started: _onStarted,
      refreshed: (event) => _onRefreshed(event, emit),
    );
  }

  Future<void> _onStarted(_Started event) async {
    add(const DisciplinesOverviewEvent.refreshed());

    await _streamSubscription?.cancel();
    _streamSubscription = _disciplinesRepository.watch().listen((_) {
      add(const DisciplinesOverviewEvent.refreshed());
    });
  }

  Future<void> _onRefreshed(
    _Refreshed event,
    Emitter<DisciplinesOverviewState> emit,
  ) async {
    emit(const DisciplinesOverviewState.loadInProgress());

    final disciplines = await _disciplinesRepository.findAll();
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
