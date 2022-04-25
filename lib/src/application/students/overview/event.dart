part of 'bloc.dart';

@freezed
class StudentsOverviewEvent with _$StudentsOverviewEvent {
  const factory StudentsOverviewEvent.started() = _Started;
  const factory StudentsOverviewEvent.refreshed({
    required List<Student> students,
  }) = _Refreshed;
}
