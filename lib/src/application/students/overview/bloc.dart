import 'dart:async' show StreamSubscription;

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/discipline.dart';
import '../../../domain/student.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

class StudentsOverviewBloc
    extends Bloc<StudentsOverviewEvent, StudentsOverviewState> {
  StudentsOverviewBloc({
    required StudentsRepository studentsRepository,
    required this.discipline,
  })  : _studentsRepository = studentsRepository,
        super(const StudentsOverviewState.initial()) {
    on<StudentsOverviewEvent>(_onEvent);
  }

  final Discipline discipline;
  final StudentsRepository _studentsRepository;

  StreamSubscription<String>? _streamSubscription;

  Future<void> _onEvent(
    StudentsOverviewEvent event,
    Emitter<StudentsOverviewState> emit,
  ) async {
    await event.map(
      started: _onStarted,
      refreshed: (event) => _onRefreshed(event, emit),
    );
  }

  Future<void> _onStarted(_Started event) async {
    add(const StudentsOverviewEvent.refreshed());

    await _streamSubscription?.cancel();
    _streamSubscription = _studentsRepository.watch().listen((_) {
      add(const StudentsOverviewEvent.refreshed());
    });
  }

  Future<void> _onRefreshed(
    _Refreshed event,
    Emitter<StudentsOverviewState> emit,
  ) async {
    emit(const StudentsOverviewState.loadInProgress());

    final students = await _studentsRepository.findAllByDisciplineId(
      discipline.id,
    );

    students.sort((a, b) => a.name.compareTo(b.name));

    if (students.isEmpty) {
      emit(const StudentsOverviewState.initial());
    } else {
      emit(StudentsOverviewState.loadSuccess(students: students));
    }
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    return super.close();
  }
}
