import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/attendee.dart';
import '../../../domain/student.dart';
import '../../../domain/usecases/find_student_attendances.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

class StudentOverviewBloc
    extends Bloc<StudentOverviewEvent, StudentOverviewState> {
  StudentOverviewBloc({
    required FindStudentAttendancesUsecase findStudentAttendances,
  })  : _findStudentAttendances = findStudentAttendances,
        super(const StudentOverviewState.loadInProgress()) {
    on<StudentOverviewEvent>(_onEvent);
  }

  final FindStudentAttendancesUsecase _findStudentAttendances;

  Future<void> _onEvent(
    StudentOverviewEvent event,
    Emitter<StudentOverviewState> emit,
  ) async {
    await event.map(
      started: (_Started event) => _onStarted(event, emit),
    );
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<StudentOverviewState> emit,
  ) async {
    final student = event.student;
    final attendees = await _findStudentAttendances(student);

    emit(
      StudentOverviewState.loadSuccess(
        student: student,
        attendees: attendees,
      ),
    );
  }
}
