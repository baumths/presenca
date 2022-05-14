import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../domain/attendance.dart';
import '../../../domain/discipline.dart';
import '../../../domain/student.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

class AttendanceFormBloc
    extends Bloc<AttendanceFormEvent, AttendanceFormState> {
  AttendanceFormBloc({
    required StudentsRepository studentsRepository,
  })  : _studentsRepository = studentsRepository,
        super(AttendanceFormState.empty()) {
    on<AttendanceFormEvent>(_onEvent);
  }

  final StudentsRepository _studentsRepository;

  Future<void> _onEvent(
    AttendanceFormEvent event,
    Emitter<AttendanceFormState> emit,
  ) async {
    await event.map(
      started: (event) => _onStarted(event, emit),
      dateChanged: (event) => _onDateChanged(event, emit),
      timeChanged: (event) => _onTimeChanged(event, emit),
    );
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<AttendanceFormState> emit,
  ) async {
    final students = await _studentsRepository.find(event.discipline.id);

    final attendees = students
        .where((student) => student.active)
        .map(Attendee.fromStudent)
        .toList(growable: false)
      ..sort((a, b) => a.student.name.compareTo(b.student.name));

    emit(
      state.copyWith(
        attendance: state.attendance.copyWith(
          disciplineId: event.discipline.id,
        ),
        attendees: attendees,
      ),
    );
  }

  Future<void> _onDateChanged(
    _DateChanged event,
    Emitter<AttendanceFormState> emit,
  ) async {
    // Only replace the date, not the time.
    final newDate = DateTime(
      event.date.year,
      event.date.month,
      event.date.day,
      state.attendance.date.hour,
      state.attendance.date.minute,
    );

    emit(
      state.copyWith(
        attendance: state.attendance.copyWith(
          date: newDate,
        ),
      ),
    );
  }

  Future<void> _onTimeChanged(
    _TimeChanged event,
    Emitter<AttendanceFormState> emit,
  ) async {
    // Only replace the time, not the date.
    final newDate = DateTime(
      state.date.year,
      state.date.month,
      state.date.day,
      event.hour,
      event.minute,
    );

    emit(
      state.copyWith(
        attendance: state.attendance.copyWith(
          date: newDate,
        ),
      ),
    );
  }
}
