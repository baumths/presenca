part of 'bloc.dart';

sealed class StudentsOverviewEvent {
  const StudentsOverviewEvent();
}

class StudentsOverviewStarted extends StudentsOverviewEvent {
  const StudentsOverviewStarted();
}
