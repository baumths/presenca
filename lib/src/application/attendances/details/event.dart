part of 'bloc.dart';

@freezed
class AttendanceDetailsEvent with _$AttendanceDetailsEvent {
  const factory AttendanceDetailsEvent.started({
    required String localeName,
  }) = _Started;
}
