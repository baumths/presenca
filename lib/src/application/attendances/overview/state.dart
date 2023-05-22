part of 'bloc.dart';

sealed class AttendancesOverviewState {
  const AttendancesOverviewState();
}

class AttendancesOverviewLoadInProgress extends AttendancesOverviewState {
  const AttendancesOverviewLoadInProgress();
}

class AttendancesOverviewLoadSuccess extends AttendancesOverviewState {
  const AttendancesOverviewLoadSuccess(this.attendances);
  final List<Attendance> attendances;
}
