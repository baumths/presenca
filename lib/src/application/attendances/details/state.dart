part of 'bloc.dart';

@freezed
class AttendanceDetailsState with _$AttendanceDetailsState {
  const AttendanceDetailsState._();

  const factory AttendanceDetailsState({
    required Map<String, bool> attendees,
    required List<Student> students,
    required bool isLoading,
  }) = _AttendanceDetailsState;

  factory AttendanceDetailsState.initial() {
    return const AttendanceDetailsState(
      attendees: {},
      students: [],
      isLoading: true,
    );
  }

  bool didStudentAttend(Student student) => attendees[student.id] ?? false;
}
