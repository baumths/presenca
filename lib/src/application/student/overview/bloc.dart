import 'package:bloc/bloc.dart';

import '../../../domain/entities/attendee.dart';
import '../../../domain/student.dart';
import '../../../domain/usecases/find_student_attendances.dart';

part 'event.dart';
part 'state.dart';

class StudentOverviewBloc
    extends Bloc<StudentOverviewEvent, StudentOverviewState> {
  StudentOverviewBloc({
    required FindStudentAttendancesUsecase findStudentAttendances,
  })  : _findStudentAttendances = findStudentAttendances,
        super(const StudentOverviewLoadInProgress()) {
    on<StudentOverviewEvent>(_onEvent);
  }

  final FindStudentAttendancesUsecase _findStudentAttendances;

  Future<void> _onEvent(
    StudentOverviewEvent event,
    Emitter<StudentOverviewState> emit,
  ) {
    return switch (event) {
      StudentOverviewStarted event => _onStarted(event, emit),
    };
  }

  Future<void> _onStarted(
    StudentOverviewStarted event,
    Emitter<StudentOverviewState> emit,
  ) async {
    final student = event.student;
    final attendees = await _findStudentAttendances(student);

    emit(StudentOverviewLoadSuccess(
      student: student,
      attendees: attendees,
    ));
  }
}
