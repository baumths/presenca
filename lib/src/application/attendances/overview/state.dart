part of 'bloc.dart';

@freezed
class AttendancesOverviewState with _$AttendancesOverviewState {
  const factory AttendancesOverviewState.loading() = AttendancesOverviewLoading;

  const factory AttendancesOverviewState.success({
    required Option<List<Attendance>> attendancesOption,
  }) = AttendancesOverviewSuccess;
}
