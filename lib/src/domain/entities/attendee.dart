import 'package:freezed_annotation/freezed_annotation.dart';

import '../student.dart';

part 'attendee.freezed.dart';

@freezed
class Attendee with _$Attendee {
  const factory Attendee({
    required String studentId,
    required String name,
    required DateTime date,
    required bool attended,
  }) = _Attendee;

  factory Attendee.fromStudent(Student student) {
    return Attendee(
      studentId: student.id,
      name: student.name,
      date: DateTime.now(),
      attended: false,
    );
  }
}
