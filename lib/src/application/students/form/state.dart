part of 'bloc.dart';

@freezed
class StudentsFormState with _$StudentsFormState {
  const StudentsFormState._();

  const factory StudentsFormState({
    required Option<Discipline> discipline,
    required Option<Student> selectedStudent,
    required List<Student> students,
    required List<String> deletedStudentIds,
    required Option<Either<StudentFailure, Unit>> failureOrSuccessOption,
  }) = _StudentsFormState;

  factory StudentsFormState.empty() {
    return const StudentsFormState(
      discipline: None(),
      selectedStudent: None(),
      students: <Student>[],
      deletedStudentIds: <String>[],
      failureOrSuccessOption: None(),
    );
  }

  bool get isEditing => selectedStudent.isSome();
}
