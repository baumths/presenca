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

  Future<void> _onEvent(
    StudentsOverviewEvent event,
    Emitter<StudentsOverviewState> emit,
  ) async {
    await event.map(
      started: (event) => _onStarted(event, emit),
    );
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<StudentsOverviewState> emit,
  ) async {
    await emit.forEach(
      _studentsRepository.watch(discipline.id),
      onError: (_, __) => const StudentsOverviewState.initial(),
      onData: (List<Student> students) {
        final activeStudents = <Student>[
          for (final Student student in students)
            if (student.active) student,
        ];

        if (activeStudents.isEmpty) {
          return const StudentsOverviewState.initial();
        }

        activeStudents.sort((a, b) => a.name.compareTo(b.name));

        return StudentsOverviewState.loadSuccess(
          students: activeStudents,
        );
      },
    );
  }
}
