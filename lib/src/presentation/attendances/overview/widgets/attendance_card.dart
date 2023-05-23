import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/attendances/details/bloc.dart';
import '../../../../domain/attendance.dart';
import '../../../../shared/shared.dart';
import '../../details/attendance_details_page.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({super.key, required this.attendance});

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

        return bloc..add(AttendanceDetailsStarted(localeName));
      },
      child: const AttendanceCardContent(),
    );
  }
}

class AttendanceCardContent extends StatelessWidget {
  const AttendanceCardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      type: MaterialType.card,
      color: theme.colorScheme.surfaceVariant.withOpacity(.3),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.colorScheme.outlineVariant),
        borderRadius: kDefaultBorderRadius,
      ),
      child: InkWell(
        borderRadius: kDefaultBorderRadius,
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            useSafeArea: true,
            showDragHandle: false,
            isScrollControlled: true,
            builder: (_) => DraggableScrollableSheet(
              expand: false,
              minChildSize: .6,
              initialChildSize: 1,
              builder: (_, scrollController) {
                return AttendanceDetailsPage(
                  bloc: context.read(),
                  scrollController: scrollController,
                );
              },
            ),
          );
        },
        child: DividerTheme(
          data: theme.dividerTheme.copyWith(
            color: theme.colorScheme.outlineVariant,
          ),
          child: const AttendanceCardBody(),
        ),
      ),
    );
  }
}

class AttendanceCardBody extends StatelessWidget {
  const AttendanceCardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AttendanceCardTitle(),
        AttendanceCardNote(),
        Divider(height: 0),
        InfoRow(),
      ],
    );
  }
}

class AttendanceCardTitle extends StatelessWidget {
  const AttendanceCardTitle({super.key});

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
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 16),
            BlocBuilder<AttendanceDetailsBloc, AttendanceDetailsState>(
              buildWhen: (p, c) {
                return p.formattedAttendanceDate != c.formattedAttendanceDate;
              },
              builder: (context, state) {
                return Text(
                  state.formattedAttendanceDate,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
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

    if (note.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: AppPadding.allMedium,
        child: Text(
          note,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconTheme(
      data: theme.iconTheme.copyWith(color: theme.colorScheme.onSurfaceVariant),
      child: const SizedBox(
        height: 48,
        child: Padding(
          padding: AppPadding.horizontalMedium,
          child: Row(
            children: [
              Flexible(child: StudentCounter()),
              VerticalDivider(width: 32),
              Flexible(child: TimeTile()),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeTile extends StatelessWidget {
  const TimeTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        const Icon(Icons.schedule),
        const SizedBox(width: 8),
        const Spacer(),
        BlocBuilder<AttendanceDetailsBloc, AttendanceDetailsState>(
          buildWhen: (p, c) {
            return p.formattedAttendanceTime != c.formattedAttendanceTime;
          },
          builder: (context, state) {
            return Text(
              state.formattedAttendanceTime,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            );
          },
        ),
      ],
    );
  }
}

class StudentCounter extends StatelessWidget {
  const StudentCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.people_alt),
        SizedBox(width: 16),
        Spacer(),
        StudentsCounterText(),
      ],
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

        return Text.rich(TextSpan(
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          children: [
            TextSpan(
              text: count,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '/$total',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ));
      },
    );
  }
}
