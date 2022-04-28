part of 'bloc.dart';

@freezed
class StudentsImportEvent with _$StudentsImportEvent {
  const factory StudentsImportEvent.pickFilePressed() = _PickFilePressed;
}
