import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/attendances/details/bloc.dart';
import '../../../../domain/attendance.dart';
import '../../../../shared/shared.dart';
import '../../details/attendance_details_page.dart';
import '../../details/widgets/attendance_title.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({
    super.key,
    required this.attendance,
  });

  final Attendance attendance;

  @override
  Widget build(BuildContext context) {
    final String localeName = context.l10n.localeName;

    return BlocProvider(
      create: (context) {
        final bloc = AttendanceDetailsBloc(
          attendance: attendance,
          studentsRepository: context.read(),
        );

        final event = AttendanceDetailsEvent.started(localeName: localeName);

        return bloc..add(event);
      },
      child: const AttendanceCardContent(),
    );
  }
}

class AttendanceCardContent extends StatelessWidget {
  const AttendanceCardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      borderRadius: kDefaultBorderRadius,
      child: InkWell(
        borderRadius: kDefaultBorderRadius,
        onTap: () async {
          await showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (_) => AttendanceDetailsPage(
              bloc: context.read(),
            ),
          );
          // AppRouter.showAttendanceDetails(context, attendance);
        },
        child: const AttendanceCardBody(),
      ),
    );
  }
}

class AttendanceCardBody extends StatelessWidget {
  const AttendanceCardBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<AttendanceDetailsBloc>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AttendanceCardHeader(),
        if (bloc.attendance.note.isEmpty)
          Divider(height: 0, color: theme.colorScheme.secondaryContainer)
        else
          const AttendanceCardNote(),
        const StudentsCountTile(),
      ],
    );
  }
}

class AttendanceCardHeader extends StatelessWidget {
  const AttendanceCardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 48,
      child: Padding(
        padding: AppPadding.horizontalMedium,
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_rounded,
              color: theme.colorScheme.onPrimaryContainer,
            ),
            const SizedBox(width: 16),
            AttendanceTitle(
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceCardNote extends StatelessWidget {
  const AttendanceCardNote({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final note = context.read<AttendanceDetailsBloc>().attendance.note;

    return SizedBox(
      width: double.infinity,
      child: ColoredBox(
        color: theme.colorScheme.secondaryContainer.withOpacity(.3),
        child: Padding(
          padding: AppPadding.allMedium,
          child: Text(
            note,
            style: theme.textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}

class StudentsCountTile extends StatelessWidget {
  const StudentsCountTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 48,
      child: Padding(
        padding: AppPadding.tile,
        child: Row(
          children: [
            Icon(Icons.people_alt, color: theme.colorScheme.secondary),
            const SizedBox(width: 16),
            Text(
              'Alunos',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.secondary,
              ),
            ),
            const Spacer(),
            const StudentsCounterText(),
          ],
        ),
      ),
    );
  }
}

class StudentsCounterText extends StatelessWidget {
  const StudentsCounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AttendanceDetailsBloc, AttendanceDetailsState>(
      builder: (context, state) {
        final count = state.attendees.length.toString();
        final total = state.students.length.toString();

        return RichText(
          text: TextSpan(
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.secondary,
            ),
            children: [
              TextSpan(
                text: count,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.secondary,
                ),
              ),
              const TextSpan(
                text: '/',
                style: TextStyle(fontSize: 16),
              ),
              TextSpan(
                text: total,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}
