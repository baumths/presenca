import 'package:bloc/bloc.dart';

import '../../../domain/attendance.dart';
import '../../../domain/discipline.dart';

part 'event.dart';
part 'state.dart';

class AttendancesOverviewBloc
    extends Bloc<AttendancesOverviewEvent, AttendancesOverviewState> {
  AttendancesOverviewBloc({
    required this.discipline,
    required AttendancesRepository attendancesRepository,
  })  : _attendancesRepository = attendancesRepository,
        super(const AttendancesOverviewLoadInProgress()) {
    on<AttendancesOverviewEvent>(_onEvent);
  }

  final Discipline discipline;
  final AttendancesRepository _attendancesRepository;

  Future<void> _onEvent(
    AttendancesOverviewEvent event,
    Emitter<AttendancesOverviewState> emit,
  ) {
    return switch (event) {
      AttendancesOverviewStarted event => _onStarted(event, emit),
    };
  }

  Future<void> _onStarted(
    AttendancesOverviewStarted event,
    Emitter<AttendancesOverviewState> emit,
  ) async {
    await emit.forEach<List<Attendance>>(
      _attendancesRepository.watch(discipline.id),
      onData: (List<Attendance> attendances) {
        attendances = List<Attendance>.of(attendances)
          ..sort((a, b) => b.date.compareTo(a.date));

        return AttendancesOverviewLoadSuccess(attendances);
      },
      onError: (_, __) => const AttendancesOverviewLoadSuccess([]),
    );
  }
}
