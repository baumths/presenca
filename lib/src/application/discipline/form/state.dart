part of 'bloc.dart';

@freezed
class DisciplineFormState with _$DisciplineFormState {
  const DisciplineFormState._();

  const factory DisciplineFormState({
    required Discipline discipline,
    required bool isEditing,
    required bool isSaving,
    required Option<Either<DisciplineFailure, Unit>> saveFailureOrSuccessOption,
    required String? errorMessage,
  }) = _DisciplineFormState;

  factory DisciplineFormState.initial() {
    return DisciplineFormState(
      discipline: Discipline.empty(),
      isEditing: false,
      isSaving: false,
      saveFailureOrSuccessOption: const None(),
      errorMessage: null,
    );
  }

  bool get canSubmit {
    return errorMessage == null &&
        saveFailureOrSuccessOption.isNone() &&
        discipline.validate();
  }
}
