import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/attendance.dart';
import '../../../domain/discipline.dart';
import '../../../domain/student.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

class AttendanceDetailsBloc
    extends Bloc<AttendanceDetailsEvent, AttendanceDetailsState> {
  AttendanceDetailsBloc({
    required this.attendance,
    required StudentsRepository studentsRepository,
  })  : _studentsRepository = studentsRepository,
        super(AttendanceDetailsState.initial()) {
    on<AttendanceDetailsEvent>(_onEvent);
  }

  final Attendance attendance;
  final StudentsRepository _studentsRepository;

  Future<void> _onEvent(
    AttendanceDetailsEvent event,
    Emitter<AttendanceDetailsState> emit,
  ) async {
    await event.map(
      started: (event) => _onStarted(event, emit),
    );
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<AttendanceDetailsState> emit,
  ) async {
    final students = await _studentsRepository.find(attendance.disciplineId);

    final attendees = <String, bool>{
      for (final String studentId in attendance.attendedStudentIds)
        studentId: true,
    };

    emit(
      state.copyWith(
        attendees: attendees,
        students: students,
        isLoading: false,
      ),
    );
  }
}
