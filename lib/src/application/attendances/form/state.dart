part of 'bloc.dart';

@freezed
class AttendanceFormState with _$AttendanceFormState {
  const AttendanceFormState._();

  const factory AttendanceFormState({
    required Attendance attendance,
    required List<Attendee> attendees,
    required Option<Either<AttendanceFailure, Unit>> saveFailureOrSuccessOption,
  }) = _AttendanceFormState;

  factory AttendanceFormState.empty() {
    return AttendanceFormState(
      attendance: Attendance.empty(),
      attendees: const <Attendee>[],
      saveFailureOrSuccessOption: const None(),
    );
  }

  DateTime get date => attendance.date;

  String formattedDate(String locale) {
    return DateFormat.MMMMd(locale).format(date);
  }

  String formattedTime(String locale) {
    return DateFormat.Hm(locale).format(date);
  }

  bool didDateChange(AttendanceFormState other) {
    return date.year != other.date.year ||
        date.month != other.date.month ||
        date.day != other.date.day;
  }

  bool didTimeChange(AttendanceFormState other) {
    return date.hour != other.date.hour || date.minute != other.date.minute;
  }
}
