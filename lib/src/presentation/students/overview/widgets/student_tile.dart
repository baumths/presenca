import 'package:flutter/material.dart';

import '../../../../domain/entities/student.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({
    Key? key,
    required this.student,
    this.tileColor,
  }) : super(key: key);

  final Student student;
  final Color? tileColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(student.name),
      tileColor: tileColor,
    );
  }
}
