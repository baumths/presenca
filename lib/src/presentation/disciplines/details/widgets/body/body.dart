import 'package:flutter/material.dart';

import '../../../../students/students.dart';

class DisciplineDetailsBody extends StatelessWidget {
  const DisciplineDetailsBody({
    Key? key,
    required this.disciplineId,
  }) : super(key: key);

  final String disciplineId;

  @override
  Widget build(BuildContext context) {
    return StudentsOverviewPage(disciplineId: disciplineId);
  }
}
