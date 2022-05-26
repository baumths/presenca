part of 'bloc.dart';

@freezed
class StudentsFormEvent with _$StudentsFormEvent {
  const factory StudentsFormEvent.started({
    required List<Student> initialStudents,
  }) = _Started;

  const factory StudentsFormEvent.selected(
    Student student,
  ) = _Selected;

  const factory StudentsFormEvent.editingComplete(
    String name,
  ) = _EditingComplete;

  const factory StudentsFormEvent.activeToggled(
    Student student,
  ) = _ActiveToggled;

  const factory StudentsFormEvent.deletePressed(
    Student student,
  ) = _DeletePressed;

  const factory StudentsFormEvent.submitted() = _Submitted;
}
