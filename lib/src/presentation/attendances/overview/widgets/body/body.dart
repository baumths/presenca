import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/attendances/overview/bloc.dart';
import '../../../../../domain/attendance.dart';
import '../../../../../shared/shared.dart';
import '../../../../app/router.dart';
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
        success: (attendances) {
          if (attendances.isEmpty) {
            return const EmptyAttendances();
          }

          return AttendancesList(
            attendances: attendances,
          );
        },
      ),
    );
  }
}
