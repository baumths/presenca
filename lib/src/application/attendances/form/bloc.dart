import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
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
    required AttendancesRepository attendancesRepository,
    required StudentsRepository studentsRepository,
  })  : _studentsRepository = studentsRepository,
        _attendancesRepository = attendancesRepository,
        super(AttendanceFormState.empty()) {
    on<AttendanceFormEvent>(_onEvent);
  }

  final AttendancesRepository _attendancesRepository;
  final StudentsRepository _studentsRepository;

  Future<void> _onEvent(
    AttendanceFormEvent event,
    Emitter<AttendanceFormState> emit,
  ) async {
    await event.map(
      started: (event) => _onStarted(event, emit),
      dateChanged: (event) => _onDateChanged(event, emit),
      timeChanged: (event) => _onTimeChanged(event, emit),
      noteChanged: (event) => _onNoteChanged(event, emit),
      attendeePressed: (event) => _onAttendeePressed(event, emit),
      submitted: (event) => _onSubmitted(event, emit),
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
        saveFailureOrSuccessOption: const None(),
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
        saveFailureOrSuccessOption: const None(),
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
        saveFailureOrSuccessOption: const None(),
        attendance: state.attendance.copyWith(
          date: newDate,
        ),
      ),
    );
  }

  Future<void> _onNoteChanged(
    _NoteChanged event,
    Emitter<AttendanceFormState> emit,
  ) async {
    emit(
      state.copyWith(
        attendance: state.attendance.copyWith(
          note: event.note,
        ),
      ),
    );
  }

  Future<void> _onAttendeePressed(
    _AttendeePressed event,
    Emitter<AttendanceFormState> emit,
  ) async {
    final newAttendees = <Attendee>[
      for (final Attendee attendee in state.attendees)
        if (attendee.student.id == event.attendee.student.id)
          attendee.copyWith(attended: !attendee.attended)
        else
          attendee,
    ];

    emit(
      state.copyWith(
        saveFailureOrSuccessOption: const None(),
        attendees: newAttendees,
      ),
    );
  }

  Future<void> _onSubmitted(
    _Submitted event,
    Emitter<AttendanceFormState> emit,
  ) async {
    final attendedStudentIds = <String>[
      for (final Attendee attendee in state.attendees)
        if (attendee.attended) attendee.student.id
    ];

    final attendance = state.attendance.copyWith(
      attendedStudentIds: attendedStudentIds,
    );

    final attendances = await _attendancesRepository.find(
      attendance.disciplineId,
    );

    final saveFailureOrSuccess = await _attendancesRepository.save(
      attendance.disciplineId,
      [...attendances, attendance],
    );

    emit(
      state.copyWith(
        attendance: attendance,
        saveFailureOrSuccessOption: Some(saveFailureOrSuccess),
      ),
    );
  }
}
