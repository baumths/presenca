part of 'bloc.dart';

sealed class StudentOverviewEvent {
  const StudentOverviewEvent();
}

class StudentOverviewStarted extends StudentOverviewEvent {
  const StudentOverviewStarted(this.student);

  final Student student;
}
