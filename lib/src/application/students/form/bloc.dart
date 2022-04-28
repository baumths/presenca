import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/discipline.dart';
import '../../../domain/student.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

class StudentsFormBloc extends Bloc<StudentsFormEvent, StudentsFormState> {
  StudentsFormBloc({
    required this.discipline,
    required StudentsRepository studentsRepository,
  })  : _studentsRepository = studentsRepository,
        super(StudentsFormState.empty()) {
    on<StudentsFormEvent>(_onEvent);
  }

  final Discipline discipline;
  final StudentsRepository _studentsRepository;

  Future<void> _onEvent(
    StudentsFormEvent event,
    Emitter<StudentsFormState> emit,
  ) async {
    await event.map(
      started: (event) => _onStarted(event, emit),
      selected: (event) => _onSelected(event, emit),
      editingComplete: (event) => _onEditingComplete(event, emit),
      activeToggled: (event) => _onActiveToggled(event, emit),
      submitted: (event) => _onSubmitted(event, emit),
    );
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<StudentsFormState> emit,
  ) async {
    late final List<Student> students;

    // TODO(future): find students in storage and warn user of overwriting
    if (event.initialStudents.isEmpty) {
      students = await _studentsRepository.find(discipline.id);
    } else {
      // TODO: allow delete of student when importing (dismissible???)
      students = List<Student>.from(event.initialStudents);
    }

    emit(
      state.copyWith(
        selectedStudent: const None(),
        failureOrSuccessOption: const None(),
        students: students,
      ),
    );
  }

  Future<void> _onSelected(
    _Selected event,
    Emitter<StudentsFormState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedStudent: Some(event.student),
        failureOrSuccessOption: const None(),
      ),
    );
  }

  Future<void> _onEditingComplete(
    _EditingComplete event,
    Emitter<StudentsFormState> emit,
  ) async {
    final String studentName = event.name.trim();

    state.selectedStudent.fold(
      () {
        // Adding new student
        if (studentName.isEmpty) {
          // Empty name, do nothing
          return;
        }

        final student = Student.empty().copyWith(
          disciplineId: discipline.id,
          name: studentName,
        );

        final newStudents = <Student>[...state.students, student];

        emit(
          state.copyWith(
            selectedStudent: const None(),
            failureOrSuccessOption: const None(),
            students: newStudents,
          ),
        );
      },
      (editingStudent) {
        // Editing student
        if (studentName.isEmpty) {
          emit(
            state.copyWith(
              failureOrSuccessOption: const Some(
                Left(StudentFailure.emptyName()),
              ),
            ),
          );
          return;
        }

        final newStudents = <Student>[
          for (final Student student in state.students)
            if (student.id == editingStudent.id)
              student.copyWith(name: studentName)
            else
              student
        ];

        emit(
          state.copyWith(
            selectedStudent: const None(),
            failureOrSuccessOption: const None(),
            students: newStudents,
          ),
        );
      },
    );
  }

  Future<void> _onActiveToggled(
    _ActiveToggled event,
    Emitter<StudentsFormState> emit,
  ) async {
    final newStudents = [
      for (final Student student in state.students)
        if (student.id == event.student.id)
          student.copyWith(
            active: !student.active,
          )
        else
          student
    ];

    emit(
      state.copyWith(
        students: newStudents,
      ),
    );
  }

  Future<void> _onSubmitted(
    _Submitted event,
    Emitter<StudentsFormState> emit,
  ) async {
    emit(
      state.copyWith(
        failureOrSuccessOption: const None(),
        isSaving: true,
      ),
    );

    final failureOrSuccess = await _studentsRepository.save(
      discipline.id,
      state.students,
    );

    emit(
      state.copyWith(
        failureOrSuccessOption: Some(failureOrSuccess),
        isSaving: false,
      ),
    );
  }
}
