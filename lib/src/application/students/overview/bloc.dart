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

  StreamSubscription<List<Student>>? _streamSubscription;

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
    await _streamSubscription?.cancel();

    final stream = _studentsRepository.watch(discipline.id);

    _streamSubscription = stream.listen((List<Student> students) {
      add(StudentsOverviewEvent.refreshed(students: students));
    });
  }

  Future<void> _onRefreshed(
    _Refreshed event,
    Emitter<StudentsOverviewState> emit,
  ) async {
    final activeStudents = <Student>[
      for (final Student student in event.students)
        if (student.active) student,
    ];

    activeStudents.sort((a, b) => a.name.compareTo(b.name));

    late final StudentsOverviewState state;

    if (activeStudents.isEmpty) {
      state = const StudentsOverviewState.initial();
    } else {
      state = StudentsOverviewState.loadSuccess(students: activeStudents);
    }

    emit(state);
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    return super.close();
  }
}
