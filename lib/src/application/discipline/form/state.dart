part of 'bloc.dart';

@freezed
class DisciplineFormState with _$DisciplineFormState {
  const DisciplineFormState._();

  const factory DisciplineFormState({
    required Discipline discipline,
    required bool isEditing,
    required Option<Either<DisciplineFailure, Unit>> saveFailureOrSuccessOption,
  }) = _DisciplineFormState;

  factory DisciplineFormState.initial() {
    return DisciplineFormState(
      discipline: Discipline.empty(),
      isEditing: false,
      saveFailureOrSuccessOption: const None(),
    );
  }

  bool get canSubmit {
    return saveFailureOrSuccessOption.isNone() && discipline.name.isNotEmpty;
  }
}
