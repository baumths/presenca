import 'package:freezed_annotation/freezed_annotation.dart';

part 'discipline_failure.freezed.dart';

@freezed
class DisciplineFailure with _$DisciplineFailure {
  const factory DisciplineFailure.unableToUpdate() = _UnableToUpdate;
}
