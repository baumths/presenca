import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/attendances/overview/bloc.dart';
import '../../../domain/attendance.dart';
import '../../../domain/discipline.dart';
import 'widgets/attendances_overview_view.dart';

class AttendancesOverviewPage extends StatelessWidget {
  const AttendancesOverviewPage({
    super.key,
    required this.discipline,
  });

  final Discipline discipline;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AttendancesOverviewBloc>(
      create: (context) {
        final bloc = AttendancesOverviewBloc(
          discipline: discipline,
          attendancesRepository: context.read<AttendancesRepository>(),
        );

        return bloc..add(const AttendancesOverviewEvent.started());
      },
      child: const AttendancesOverviewView(),
    );
  }
}
