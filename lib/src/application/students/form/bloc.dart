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
    required StudentsRepository studentsRepository,
  })  : _studentsRepository = studentsRepository,
        super(StudentsFormState.empty()) {
    on<StudentsFormEvent>(_onEvent);
  }

  final StudentsRepository _studentsRepository;

  Future<void> _onEvent(
    StudentsFormEvent event,
    Emitter<StudentsFormState> emit,
  ) async {
    await event.map(
      started: (event) => _onStarted(event, emit),
      selected: (event) => _onSelected(event, emit),
      editingComplete: (event) => _onEditingComplete(event, emit),
      deleted: (event) => _onDeleted(event, emit),
      restored: (event) => _onRestored(event, emit),
      submitted: (event) {},
    );
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<StudentsFormState> emit,
  ) async {
    final discipline = event.discipline;
    final students = await _studentsRepository.findAllByDisciplineId(
      discipline.id,
    );

    emit(
      state.copyWith(
        discipline: Some(discipline),
        selectedStudent: const None(),
        failureOrSuccessOption: const None(),
        students: students..sort(byStudentName),
      ),
    );
  }

  Future<void> _onSelected(
    _Selected event,
    Emitter<StudentsFormState> emit,
  ) async {
    state.discipline.fold(
      () {
        // TODO: maybe show 'Something went wrong, please try again.'
      },
      (discipline) {
        // TODO(future): fold [state.selectedStudent] and show popup to discard changes
        emit(
          state.copyWith(
            selectedStudent: Some(event.student),
            failureOrSuccessOption: const None(),
          ),
        );
      },
    );
  }

  Future<void> _onEditingComplete(
    _EditingComplete event,
    Emitter<StudentsFormState> emit,
  ) async {
    final String studentName = event.name.trim();

    state.discipline.fold(
      () {
        // TODO: maybe show 'Something went wrong, please try again.'
      },
      (discipline) {
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
                students: newStudents..sort(byStudentName),
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
                students: newStudents..sort(byStudentName),
              ),
            );
          },
        );
      },
    );
  }

  // TODO: update deleted/restore to [active] flag of [Student] entity

  Future<void> _onDeleted(
    _Deleted event,
    Emitter<StudentsFormState> emit,
  ) async {
    emit(
      state.copyWith(
        failureOrSuccessOption: const None(),
        deletedStudentIds: [...state.deletedStudentIds, event.student.id],
      ),
    );
  }

  Future<void> _onRestored(
    _Restored event,
    Emitter<StudentsFormState> emit,
  ) async {
    emit(
      state.copyWith(
        deletedStudentIds: state.deletedStudentIds
            .where((id) => id != event.student.id)
            .toList(),
      ),
    );
  }
}

int byStudentName(Student a, Student b) => a.name.compareTo(b.name);
