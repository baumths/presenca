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

  StreamSubscription<List<Discipline>>? _streamSubscription;

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
    await _streamSubscription?.cancel();

    final stream = _disciplinesRepository.watch();

    _streamSubscription = stream.listen((List<Discipline> disciplines) {
      add(DisciplinesOverviewEvent.refreshed(disciplines: disciplines));
    });
  }

  Future<void> _onRefreshed(
    _Refreshed event,
    Emitter<DisciplinesOverviewState> emit,
  ) async {
    late final DisciplinesOverviewState state;

    if (event.disciplines.isEmpty) {
      state = const DisciplinesOverviewState.initial();
    } else {
      state = DisciplinesOverviewState.loadSuccess(
        disciplines: event.disciplines,
      );
    }

    emit(state);
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    return super.close();
  }
}
