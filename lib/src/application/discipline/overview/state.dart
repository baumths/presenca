part of 'bloc.dart';

sealed class DisciplinesOverviewState {
  const DisciplinesOverviewState();
}

class DisciplinesOverviewLoadInProgress extends DisciplinesOverviewState {
  const DisciplinesOverviewLoadInProgress();
}

class DisciplinesOverviewLoadSuccess extends DisciplinesOverviewState {
  const DisciplinesOverviewLoadSuccess(this.disciplines);

  final List<Discipline> disciplines;
}
