part of 'bloc.dart';

@freezed
class StudentOverviewState with _$StudentOverviewState {
  const factory StudentOverviewState.loadInProgress() =
      StudentOverviewLoadInProgress;

  const factory StudentOverviewState.loadSuccess({
    required Student student,
    required List<Attendee> attendees,
  }) = StudentOverviewLoadSuccess;
}
