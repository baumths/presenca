import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/student.dart';

part 'student_failure.freezed.dart';

@freezed
class StudentFailure with _$StudentFailure {
  const factory StudentFailure.unableToUpdate({
    required Student student,
  }) = _UnableToUpdate;

  const factory StudentFailure.emptyName() = _EmptyName;
}
