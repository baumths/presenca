import 'package:flutter/material.dart';

import '../../../../domain/attendance.dart';
import '../../../../shared/shared.dart';
import '../../../app/router.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({
    super.key,
    required this.attendance,
  });

  final Attendance attendance;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: () => AppRouter.showAttendanceDetails(context, attendance),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 2),
          borderRadius: kDefaultBorderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                attendance.date.toIso8601String(),
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Flexible(
                child: Text(
                  attendance.note,
                  style: textTheme.bodySmall,
                ),
              ),
              // TODO: show attendees counter
            ],
          ),
        ),
      ),
    );
  }
}
