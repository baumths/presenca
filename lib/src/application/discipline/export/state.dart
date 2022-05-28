part of 'cubit.dart';

@freezed
class DisciplineExportState with _$DisciplineExportState {
  const DisciplineExportState._();

  const factory DisciplineExportState.initial() = _Initial;
  const factory DisciplineExportState.loading() = _Loading;
  const factory DisciplineExportState.success() = _Success;

  bool get isLoading => maybeWhen(loading: () => true, orElse: () => false);
}
