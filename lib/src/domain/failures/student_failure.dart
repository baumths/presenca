import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_failure.freezed.dart';

@freezed
class StudentFailure with _$StudentFailure {
  const factory StudentFailure.unableToUpdate() = _UnableToUpdate;

  const factory StudentFailure.emptyName() = _EmptyName;
}
