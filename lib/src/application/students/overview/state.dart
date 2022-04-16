part of 'bloc.dart';

@freezed
class StudentsOverviewState with _$StudentsOverviewState {
  const factory StudentsOverviewState.initial() = StudentsOverviewInitial;

  const factory StudentsOverviewState.loadInProgress() =
      StudentsOverviewLoadInProgress;

  const factory StudentsOverviewState.loadSuccess({
    required List<Student> students,
  }) = StudentsOverviewLoadSuccess;
}
