import 'dart:async' show StreamSubscription;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/student.dart';

part 'students_overview_bloc.freezed.dart';
part 'students_overview_event.dart';
part 'students_overview_state.dart';

class StudentsOverviewBloc
    extends Bloc<StudentsOverviewEvent, StudentsOverviewState> {
  StudentsOverviewBloc({
    required StudentsRepository studentsRepository,
    required this.disciplineId,
  })  : _studentsRepository = studentsRepository,
        super(const StudentsOverviewState.initial()) {
    on<StudentsOverviewEvent>(_onEvent);
  }

  final String disciplineId;
  final StudentsRepository _studentsRepository;

  StreamSubscription<String>? _streamSubscription;

  Future<void> _onEvent(
    StudentsOverviewEvent event,
    Emitter<StudentsOverviewState> emit,
  ) async {
    await event.map(
      initialized: _onInitialized,
      refreshed: (event) => _onRefreshed(event, emit),
    );
  }

  Future<void> _onInitialized(StudentsOverviewInitialized event) async {
    add(const StudentsOverviewEvent.refreshed());

    await _streamSubscription?.cancel();
    _streamSubscription = _studentsRepository.watch().listen((_) {
      add(const StudentsOverviewEvent.refreshed());
    });
  }

  Future<void> _onRefreshed(
    StudentsOverviewRefreshed event,
    Emitter<StudentsOverviewState> emit,
  ) async {
    emit(const StudentsOverviewState.loadInProgress());

    final students =
        await _studentsRepository.findAllByDisciplineId(disciplineId);

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
