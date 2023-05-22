part of 'bloc.dart';

sealed class DisciplinesOverviewEvent {
  const DisciplinesOverviewEvent();
}

class DisciplinesOverviewStarted extends DisciplinesOverviewEvent {
  const DisciplinesOverviewStarted();
}
