import 'package:flutter/material.dart';

import '../../../../domain/entities/student.dart';
import '../../../../shared/shared.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({
    super.key,
    required this.student,
  });

  final Student student;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: kDefaultBorderRadius / 2,
      ),
      child: Padding(
        padding: AppPadding.tile,
        child: Text(student.name, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
