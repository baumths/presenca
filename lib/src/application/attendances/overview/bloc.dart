import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/attendance.dart';
import '../../../domain/discipline.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

class AttendancesOverviewBloc
    extends Bloc<AttendancesOverviewEvent, AttendancesOverviewState> {
  AttendancesOverviewBloc({
    required this.discipline,
    required AttendancesRepository attendancesRepository,
  })  : _attendancesRepository = attendancesRepository,
        super(const AttendancesOverviewState.loading()) {
    on<AttendancesOverviewEvent>(_onEvent);
  }

  final Discipline discipline;
  final AttendancesRepository _attendancesRepository;

  Future<void> _onEvent(
    AttendancesOverviewEvent event,
    Emitter<AttendancesOverviewState> emit,
  ) async {
    await event.map(
      started: (event) => _onStarted(event, emit),
    );
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<AttendancesOverviewState> emit,
  ) async {
    await emit.forEach<List<Attendance>>(
      _attendancesRepository.watch(discipline.id),
      onData: (List<Attendance> attendances) {
        attendances = List<Attendance>.of(attendances)
          ..sort((a, b) => b.date.compareTo(a.date));

        return AttendancesOverviewState.success(
          attendances: attendances,
        );
      },
      onError: (_, __) {
        return const AttendancesOverviewState.success(
          attendances: [],
        );
      },
    );
  }
}
