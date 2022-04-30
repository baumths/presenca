part of 'bloc.dart';

@freezed
class AttendancesOverviewEvent with _$AttendancesOverviewEvent {
  const factory AttendancesOverviewEvent.started() = _Started;
}
