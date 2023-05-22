import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/attendances/overview/bloc.dart';
import '../../../domain/attendance.dart';
import '../../../domain/discipline.dart';
import '../../app/router.dart';
import 'widgets/attendance_card.dart';

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

        return bloc..add(const AttendancesOverviewStarted());
      },
      child: const AttendancesOverviewView(),
    );
  }
}

class AttendancesOverviewView extends StatelessWidget {
  const AttendancesOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendancesOverviewBloc, AttendancesOverviewState>(
      builder: (context, state) => switch (state) {
        AttendancesOverviewLoadInProgress() => const LoadingAttendances(),
        AttendancesOverviewLoadSuccess state when state.attendances.isEmpty =>
          const EmptyAttendances(),
        AttendancesOverviewLoadSuccess state => ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: state.attendances.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final attendance = state.attendances[index];

              return AttendanceCard(
                key: Key(attendance.id),
                attendance: attendance,
              );
            },
          ),
      },
    );
  }
}

class LoadingAttendances extends StatelessWidget {
  const LoadingAttendances({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Buscando chamadas...'),
          ],
        ),
      ),
    );
  }
}

class EmptyAttendances extends StatelessWidget {
  const EmptyAttendances({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const Spacer(flex: 8),
          const Text(
            'Essa disciplina ainda não possui chamadas.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: colorScheme.secondaryContainer,
              textStyle: TextStyle(color: colorScheme.onSecondaryContainer),
            ),
            onPressed: () {
              AppRouter.showAttendanceForm(
                context,
                context.read<AttendancesOverviewBloc>().discipline,
              );
            },
            child: const Text('Iniciar Chamada'),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
