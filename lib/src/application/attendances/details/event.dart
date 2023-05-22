part of 'bloc.dart';

sealed class AttendanceDetailsEvent {
  const AttendanceDetailsEvent();
}

class AttendanceDetailsStarted extends AttendanceDetailsEvent {
  const AttendanceDetailsStarted(this.localeName);
  final String localeName;
}
