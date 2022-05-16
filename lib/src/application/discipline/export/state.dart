part of 'cubit.dart';

@freezed
class DisciplineExportState with _$DisciplineExportState {
  const factory DisciplineExportState({
    required bool isLoading,
  }) = _DisciplineExportState;

  factory DisciplineExportState.initial() {
    return const DisciplineExportState(
      isLoading: false,
    );
  }
}
