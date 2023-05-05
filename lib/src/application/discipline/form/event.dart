part of 'bloc.dart';

@freezed
class DisciplineFormEvent with _$DisciplineFormEvent {
  const factory DisciplineFormEvent.started(
    Discipline? editingDiscipline,
  ) = _Started;
  const factory DisciplineFormEvent.nameChanged(String name) = _NameChanged;
  const factory DisciplineFormEvent.archivePressed() = _ArchivePressed;
  const factory DisciplineFormEvent.submitted() = _Submitted;
}
