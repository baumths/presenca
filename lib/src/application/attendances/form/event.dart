part of 'bloc.dart';

sealed class AttendanceFormEvent {
  const AttendanceFormEvent();
}

class AttendanceFormStarted extends AttendanceFormEvent {
  const AttendanceFormStarted(this.discipline);
  final Discipline discipline;
}

class AttendanceFormDateChanged extends AttendanceFormEvent {
  const AttendanceFormDateChanged(this.date);
  final DateTime date;
}

class AttendanceFormTimeChanged extends AttendanceFormEvent {
  const AttendanceFormTimeChanged({required this.hour, required this.minute});
  final int hour;
  final int minute;
}

class AttendanceFormNoteChanged extends AttendanceFormEvent {
  const AttendanceFormNoteChanged(this.note);
  final String note;
}

class AttendanceFormAttendeePressed extends AttendanceFormEvent {
  const AttendanceFormAttendeePressed(this.attendee);
  final Attendee attendee;
}

class AttendanceFormSubmitted extends AttendanceFormEvent {
  const AttendanceFormSubmitted();
}
