import 'package:bloc/bloc.dart';

import '../../../domain/discipline.dart';
import '../../../domain/student.dart';

part 'event.dart';
part 'state.dart';

class StudentsOverviewBloc
    extends Bloc<StudentsOverviewEvent, StudentsOverviewState> {
  StudentsOverviewBloc({
    required StudentsRepository studentsRepository,
    required this.discipline,
  })  : _studentsRepository = studentsRepository,
        super(const StudentsOverviewInitial()) {
    on<StudentsOverviewEvent>(_onEvent);
  }

  final Discipline discipline;
  final StudentsRepository _studentsRepository;

  Future<void> _onEvent(
    StudentsOverviewEvent event,
    Emitter<StudentsOverviewState> emit,
  ) {
    return switch (event) {
      StudentsOverviewStarted event => _onStarted(event, emit),
    };
  }

  Future<void> _onStarted(
    StudentsOverviewStarted event,
    Emitter<StudentsOverviewState> emit,
  ) async {
    await emit.forEach(
      _studentsRepository.watch(discipline.id),
      onError: (_, __) => const StudentsOverviewInitial(),
      onData: (List<Student> students) {
        final activeStudents = <Student>[
          for (final Student student in students)
            if (student.active) student,
        ];

        if (activeStudents.isEmpty) {
          return const StudentsOverviewInitial();
        }

        activeStudents.sort((a, b) => a.name.compareTo(b.name));
        return StudentsOverviewLoadSuccess(activeStudents);
      },
    );
  }
}
