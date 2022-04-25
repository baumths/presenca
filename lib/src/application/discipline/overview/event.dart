part of 'bloc.dart';

@freezed
class DisciplinesOverviewEvent with _$DisciplinesOverviewEvent {
  const factory DisciplinesOverviewEvent.started() = _Started;
  const factory DisciplinesOverviewEvent.refreshed({
    required List<Discipline> disciplines,
  }) = _Refreshed;
}
