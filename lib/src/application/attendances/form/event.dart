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

  const factory AttendanceFormEvent.noteChanged(String note) = _NoteChanged;

  const factory AttendanceFormEvent.attendeePressed(
    Attendee attendee,
  ) = _AttendeePressed;

  const factory AttendanceFormEvent.submitted() = _Submitted;
}
