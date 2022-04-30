import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_failure.freezed.dart';

@freezed
class AttendanceFailure with _$AttendanceFailure {
  const factory AttendanceFailure.unableToUpdate() = _UnableToUpdate;
}
