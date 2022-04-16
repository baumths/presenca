part of 'bloc.dart';

@freezed
class DisciplineFormEvent with _$DisciplineFormEvent {
  const factory DisciplineFormEvent.started(
    Option<Discipline> initialDisciplineOption,
  ) = _Started;
  const factory DisciplineFormEvent.nameChanged(String name) = _NameChanged;
  const factory DisciplineFormEvent.submitted() = _Submitted;
}
