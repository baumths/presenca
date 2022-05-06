import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../application/attendances/details/bloc.dart';
import '../../../../domain/attendance.dart';
import '../../../../shared/shared.dart';
import '../../../app/router.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({
    super.key,
    required this.attendance,
  });

  final Attendance attendance;

  String formattedDate(String locale) {
    return DateFormat.yMMMEd(locale).format(attendance.date);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final noteBackgroundColor = colorScheme.secondaryContainer.withOpacity(.3);

    return Material(
      type: MaterialType.card,
      borderRadius: kDefaultBorderRadius,
      child: InkWell(
        borderRadius: kDefaultBorderRadius,
        onTap: () => AppRouter.showAttendanceDetails(context, attendance),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AttendanceCardHeader(
              title: formattedDate(context.l10n.localeName),
              color: colorScheme.onPrimaryContainer,
              textStyle: textTheme.bodyLarge,
            ),
            if (attendance.note.isEmpty)
              Divider(height: 0, color: colorScheme.secondaryContainer)
            else
              AttendanceCardNote(
                note: attendance.note,
                backgroundColor: noteBackgroundColor,
                textStyle: textTheme.bodySmall,
              ),
            StudentsCountTile(
              color: colorScheme.secondary,
              textTheme: textTheme,
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceCardHeader extends StatelessWidget {
  const AttendanceCardHeader({
    super.key,
    required this.title,
    required this.color,
    this.textStyle,
  });

  final String title;
  final Color color;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Padding(
        padding: AppPadding.horizontalMedium,
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_rounded,
              color: color,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: textStyle?.copyWith(
                color: color,
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
  const AttendanceCardNote({
    super.key,
    required this.note,
    required this.backgroundColor,
    this.textStyle,
  });

  final String note;
  final TextStyle? textStyle;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: Padding(
        padding: AppPadding.allMedium,
        child: Text(
          note,
          style: textStyle,
        ),
      ),
    );
  }
}

class StudentsCountTile extends StatelessWidget {
  const StudentsCountTile({
    super.key,
    required this.textTheme,
    required this.color,
  });

  final TextTheme textTheme;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Padding(
        padding: AppPadding.tile,
        child: Row(
          children: [
            Icon(Icons.people_alt, color: color),
            const SizedBox(width: 16),
            Text(
              'Alunos',
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
            const Spacer(),
            StudentsCounterText(
              color: color,
              textStyle: textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class StudentsCounterText extends StatelessWidget {
  const StudentsCounterText({
    super.key,
    required this.color,
    this.textStyle,
  });

  final Color color;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceDetailsBloc, AttendanceDetailsState>(
      builder: (context, state) {
        final count = state.attendees.length.toString();
        final total = state.students.length.toString();

        return RichText(
          text: TextSpan(
            style: textStyle?.copyWith(color: color),
            children: [
              TextSpan(
                text: count,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: color,
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
