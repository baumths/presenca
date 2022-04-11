part of 'disciplines_overview_bloc.dart';

@freezed
class DisciplinesOverviewState with _$DisciplinesOverviewState {
  const factory DisciplinesOverviewState.initial() = DisciplinesOverviewInitial;

  const factory DisciplinesOverviewState.loading() = DisciplinesOverviewLoading;

  const factory DisciplinesOverviewState.success({
    required List<Discipline> disciplines,
  }) = DisciplinesOverviewSuccess;
}
