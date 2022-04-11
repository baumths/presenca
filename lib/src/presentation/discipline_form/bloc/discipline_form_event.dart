part of 'discipline_form_bloc.dart';

@freezed
class DisciplineFormEvent with _$DisciplineFormEvent {
  const factory DisciplineFormEvent.initialized(
    Option<Discipline> initialDisciplineOption,
  ) = DisciplineFormInitialized;

  const factory DisciplineFormEvent.nameChanged(
    String name,
  ) = DisciplineFormNameChanged;

  const factory DisciplineFormEvent.submitted() = DisciplineFormSubmitted;
}
