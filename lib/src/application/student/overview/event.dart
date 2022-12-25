part of 'bloc.dart';

@freezed
class StudentOverviewEvent with _$StudentOverviewEvent {
  const factory StudentOverviewEvent.started(Student student) = _Started;
}
