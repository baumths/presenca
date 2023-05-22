part of 'bloc.dart';

sealed class DisciplineFormEvent {
  const DisciplineFormEvent();
}

class DisciplineFormStarted extends DisciplineFormEvent {
  const DisciplineFormStarted(this.editingDiscipline);

  final Discipline? editingDiscipline;
}

class DisciplineFormNameChanged extends DisciplineFormEvent {
  const DisciplineFormNameChanged(this.name);

  final String name;
}

class DisciplineFormArchivePressed extends DisciplineFormEvent {
  const DisciplineFormArchivePressed();
}

class DisciplineFormSubmitted extends DisciplineFormEvent {
  const DisciplineFormSubmitted();
}
