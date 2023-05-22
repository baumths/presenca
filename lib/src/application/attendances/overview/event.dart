part of 'bloc.dart';

sealed class AttendancesOverviewEvent {
  const AttendancesOverviewEvent();
}

class AttendancesOverviewStarted extends AttendancesOverviewEvent {
  const AttendancesOverviewStarted();
}
