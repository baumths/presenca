part of 'students_overview_bloc.dart';

@freezed
class StudentsOverviewEvent with _$StudentsOverviewEvent {
  const factory StudentsOverviewEvent.initialized() =
      StudentsOverviewInitialized;

  const factory StudentsOverviewEvent.refreshed() = StudentsOverviewRefreshed;
}
