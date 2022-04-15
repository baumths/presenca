part of 'disciplines_overview_bloc.dart';

@freezed
class DisciplinesOverviewState with _$DisciplinesOverviewState {
  const factory DisciplinesOverviewState.initial() = DisciplinesOverviewInitial;

  const factory DisciplinesOverviewState.loadInProgress() =
      DisciplinesOverviewLoadInProgress;

  const factory DisciplinesOverviewState.loadSuccess({
    required List<Discipline> disciplines,
  }) = DisciplinesOverviewLoadSuccess;
}
