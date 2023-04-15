import 'package:flutter/material.dart';

import '../../../../domain/entities/student.dart';
import '../../../app/router.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({
    super.key,
    required this.student,
  });

  final Student student;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      onTap: () => AppRouter.showStudentOverview(context, student),
      tileColor: colorScheme.surfaceVariant.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colorScheme.outlineVariant),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      title: Text(
        student.name,
        style: TextStyle(
          fontSize: 14,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
