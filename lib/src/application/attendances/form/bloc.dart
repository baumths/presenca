import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../domain/attendance.dart';
import '../../../domain/discipline.dart';
import '../../../domain/entities/attendee.dart';
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
  ) {
    return switch (event) {
      AttendanceFormStarted event => _onStarted(event, emit),
      AttendanceFormDateChanged event => _onDateChanged(event, emit),
      AttendanceFormTimeChanged event => _onTimeChanged(event, emit),
      AttendanceFormNoteChanged event => _onNoteChanged(event, emit),
      AttendanceFormAttendeePressed event => _onAttendeePressed(event, emit),
      AttendanceFormSubmitted event => _onSubmitted(event, emit),
    };
  }

  Future<void> _onStarted(
    AttendanceFormStarted event,
    Emitter<AttendanceFormState> emit,
  ) async {
    final students = await _studentsRepository.find(event.discipline.id);

    final attendees = students
        .where((student) => student.active)
        .map(Attendee.fromStudent)
        .toList(growable: false)
      ..sort((a, b) => a.name.compareTo(b.name));

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
    AttendanceFormDateChanged event,
    Emitter<AttendanceFormState> emit,
  ) {
    // Only replace the date, not the time.
    final newDate = DateTime(
      event.date.year,
      event.date.month,
      event.date.day,
      state.attendance.date.hour,
      state.attendance.date.minute,
    );

    emit(state.copyWith(
      saveFailureOrSuccessOption: const None(),
      attendance: state.attendance.copyWith(
        date: newDate,
      ),
    ));

    return Future.value();
  }

  Future<void> _onTimeChanged(
    AttendanceFormTimeChanged event,
    Emitter<AttendanceFormState> emit,
  ) {
    // Only replace the time, not the date.
    final newDate = DateTime(
      state.date.year,
      state.date.month,
      state.date.day,
      event.hour,
      event.minute,
    );

    emit(state.copyWith(
      saveFailureOrSuccessOption: const None(),
      attendance: state.attendance.copyWith(
        date: newDate,
      ),
    ));

    return Future.value();
  }

  Future<void> _onNoteChanged(
    AttendanceFormNoteChanged event,
    Emitter<AttendanceFormState> emit,
  ) {
    emit(state.copyWith(
      attendance: state.attendance.copyWith(
        note: event.note,
      ),
    ));

    return Future.value();
  }

  Future<void> _onAttendeePressed(
    AttendanceFormAttendeePressed event,
    Emitter<AttendanceFormState> emit,
  ) {
    final newAttendees = <Attendee>[
      for (final Attendee attendee in state.attendees)
        if (attendee.studentId == event.attendee.studentId)
          attendee.copyWith(attended: !attendee.attended)
        else
          attendee,
    ];

    emit(state.copyWith(
      saveFailureOrSuccessOption: const None(),
      attendees: newAttendees,
    ));

    return Future.value();
  }

  Future<void> _onSubmitted(
    AttendanceFormSubmitted event,
    Emitter<AttendanceFormState> emit,
  ) async {
    final attendedStudentIds = <String>[
      for (final Attendee attendee in state.attendees)
        if (attendee.attended) attendee.studentId
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

    emit(state.copyWith(
      attendance: attendance,
      saveFailureOrSuccessOption: Some(saveFailureOrSuccess),
    ));
  }
}
