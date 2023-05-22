import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../application/student/overview/bloc.dart';
import '../../../../domain/entities/attendee.dart';
import '../../../../domain/entities/student.dart';
import '../../../../shared/shared.dart';

class StudentOverviewView extends StatelessWidget {
  const StudentOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Detalhes do(a) Aluno(a)',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: BlocBuilder<StudentOverviewBloc, StudentOverviewState>(
        builder: (BuildContext context, StudentOverviewState state) {
          return switch (state) {
            StudentOverviewLoadInProgress() => const _LoadingStudent(),
            StudentOverviewLoadSuccess state => StudentOverview(
                student: state.student,
                attendees: state.attendees,
              ),
          };
        },
      ),
    );
  }
}

class _LoadingStudent extends StatelessWidget {
  const _LoadingStudent();

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
            Text('Carregando detalhes do(a) aluno(a)...'),
          ],
        ),
      ),
    );
  }
}

class StudentOverview extends StatelessWidget {
  const StudentOverview({
    super.key,
    required this.student,
    required this.attendees,
  });

  final Student student;
  final List<Attendee> attendees;

  @override
  Widget build(BuildContext context) {
    final int total = attendees.length;
    final int count = attendees.where((entry) => entry.attended).length;

    final String locale = context.l10n.localeName;
    final DateFormat dateFormatter = DateFormat('MMMd', locale);
    final DateFormat timeFormatter = DateFormat('HH:mm', locale);

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            _StudentSummary(
              studentName: student.name,
              attendeesCount: count,
              totalAttendances: total,
            ),
            const SizedBox(height: 24),
            const _SectionHeader('Grade de Chamadas'),
          ]),
        ),
        if (attendees.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 128,
                mainAxisExtent: 64,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: attendees.length,
                (BuildContext context, int index) {
                  final Attendee attendee = attendees[index];

                  return AttendeeTile(
                    date: dateFormatter.format(attendee.date),
                    time: timeFormatter.format(attendee.date),
                    attended: attendee.attended,
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

class _StudentSummary extends StatelessWidget {
  const _StudentSummary({
    required this.studentName,
    required this.totalAttendances,
    required this.attendeesCount,
  });

  final String studentName;
  final int totalAttendances;
  final int attendeesCount;

  @override
  Widget build(BuildContext context) {
    Widget? subtitle;

    if (totalAttendances > 0) {
      const numberTextStyle = TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );

      subtitle = Text.rich(TextSpan(
        children: [
          const TextSpan(text: 'Presente em '),
          TextSpan(
            text: attendeesCount.toString(),
            style: numberTextStyle,
          ),
          const TextSpan(text: ' de '),
          TextSpan(
            text: totalAttendances.toString(),
            style: numberTextStyle,
          ),
          totalAttendances == 1
              ? const TextSpan(text: ' chamada')
              : const TextSpan(text: ' chamadas'),
        ],
      ));
    }

    return ListTile(
      title: Text(studentName),
      subtitle: subtitle,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

class AttendeeTile extends StatelessWidget {
  const AttendeeTile({
    super.key,
    required this.date,
    required this.time,
    required this.attended,
  });

  final String date;
  final String time;
  final bool attended;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color accentColor = attended ? Colors.green : Colors.red;

    return ClipRRect(
      borderRadius: BorderRadius.all(kDefaultRadius / 2),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant.withOpacity(.3),
          border: Border(top: BorderSide(color: accentColor, width: 3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: DefaultTextStyle(
            style: TextStyle(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(date),
                Text(
                  time,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
