part of 'bloc.dart';

@freezed
class StudentsFormState with _$StudentsFormState {
  const StudentsFormState._();

  const factory StudentsFormState({
    required Option<Student> selectedStudent,
    required List<Student> students,
    required bool isSaving,
    required Option<Either<StudentFailure, Unit>> failureOrSuccessOption,
  }) = _StudentsFormState;

  factory StudentsFormState.empty() {
    return const StudentsFormState(
      selectedStudent: None(),
      students: <Student>[],
      isSaving: false,
      failureOrSuccessOption: None(),
    );
  }

  bool get isEditing => selectedStudent.isSome();
}
