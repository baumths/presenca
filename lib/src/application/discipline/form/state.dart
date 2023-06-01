part of 'bloc.dart';

@freezed
class DisciplineFormState with _$DisciplineFormState {
  const DisciplineFormState._();

  const factory DisciplineFormState({
    required Discipline discipline,
    required bool isEditing,
    required DisciplineImportResult importResult,
    required Option<Either<DisciplineFailure, Unit>> saveFailureOrSuccessOption,
  }) = _DisciplineFormState;

  factory DisciplineFormState.initial() {
    return DisciplineFormState(
      discipline: Discipline.empty(),
      isEditing: false,
      importResult: const DisciplineImportInitial(),
      saveFailureOrSuccessOption: const None(),
    );
  }

  bool get canSubmit {
    return saveFailureOrSuccessOption.isNone() && discipline.name.isNotEmpty;
  }
}

sealed class DisciplineImportResult {
  const DisciplineImportResult();
}

final class DisciplineImportInitial extends DisciplineImportResult {
  const DisciplineImportInitial();
}

final class DisciplineImportLoading extends DisciplineImportResult {
  const DisciplineImportLoading();
}

final class DisciplineImportSuccess extends DisciplineImportResult {
  const DisciplineImportSuccess({
    required this.students,
    required this.attendances,
  });

  final List<Student> students;
  final List<Attendance> attendances;
}

final class DisciplineImportFailure extends DisciplineImportResult {
  const DisciplineImportFailure(this.message);
  final String message;
}
