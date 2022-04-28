part of 'bloc.dart';

@freezed
class StudentsImportState with _$StudentsImportState {
  const factory StudentsImportState({
    required Option<List<Student>> students,
    required bool isLoading,
  }) = _StudentsImportState;

  factory StudentsImportState.initial() {
    return const StudentsImportState(
      students: None(),
      isLoading: false,
    );
  }
}
