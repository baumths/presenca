part of 'bloc.dart';

@freezed
class DisciplinesOverviewState with _$DisciplinesOverviewState {
  const factory DisciplinesOverviewState.loadInProgress() = _LoadInProgress;
  const factory DisciplinesOverviewState.loadSuccess({
    required List<Discipline> disciplines,
  }) = _LoadSuccess;
}
