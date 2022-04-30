import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/attendances/overview/bloc.dart';
import '../../../../../domain/attendance.dart';
import '../../../../../shared/shared.dart';
import '../attendance_card.dart';

part '_empty.dart';
part '_loading.dart';
part '_success.dart';

class AttendancesOverviewBody extends StatelessWidget {
  const AttendancesOverviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendancesOverviewBloc, AttendancesOverviewState>(
      builder: (context, state) => state.when(
        loading: () => const LoadingAttendances(),
        success: (attendancesOption) => attendancesOption.fold(
          () {
            return AttendancesList(
              attendances: [
                Attendance.empty(),
                Attendance.empty(),
                Attendance.empty(),
                Attendance.empty(),
                Attendance.empty(),
              ],
            );
            return const EmptyAttendances();
          },
          (attendances) => AttendancesList(attendances: attendances),
        ),
      ),
    );
  }
}
