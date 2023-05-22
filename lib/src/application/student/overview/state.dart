part of 'bloc.dart';

sealed class StudentOverviewState {
  const StudentOverviewState();
}

class StudentOverviewLoadInProgress extends StudentOverviewState {
  const StudentOverviewLoadInProgress();
}

class StudentOverviewLoadSuccess extends StudentOverviewState {
  const StudentOverviewLoadSuccess({
    required this.student,
    required this.attendees,
  });

  final Student student;
  final List<Attendee> attendees;
}
