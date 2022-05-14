part of 'bloc.dart';

@freezed
class AttendanceFormEvent with _$AttendanceFormEvent {
  const factory AttendanceFormEvent.started({
    required Discipline discipline,
  }) = _Started;

  const factory AttendanceFormEvent.dateChanged(DateTime date) = _DateChanged;

  const factory AttendanceFormEvent.timeChanged({
    required int hour,
    required int minute,
  }) = _TimeChanged;
}
