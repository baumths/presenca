part of 'disciplines_overview_bloc.dart';

@freezed
class DisciplinesOverviewEvent with _$DisciplinesOverviewEvent {
  const factory DisciplinesOverviewEvent.initialized() =
      DisciplinesOverviewInitialized;

  const factory DisciplinesOverviewEvent.refresh() =
      DisciplinesOverviewRefreshed;
}
