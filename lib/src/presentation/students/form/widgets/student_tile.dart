import 'package:flutter/material.dart';

import '../../../../domain/student.dart';
import '../../../../shared/shared.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({
    Key? key,
    required this.student,
  }) : super(key: key);

  final Student student;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
      title: Text(
        student.name,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: IconButton(
        splashRadius: 24,
        visualDensity: kVisualDensity,
        icon: const Icon(Icons.delete),
        onPressed: () {},
      ),
      onTap: () {
        // TODO: populate input with [student]
      },
    );
  }
}
