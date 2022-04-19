import 'package:flutter/material.dart';

import '../../../../../domain/discipline.dart';
import '../../../../students/students.dart';

class DisciplineDetailsBody extends StatelessWidget {
  const DisciplineDetailsBody({
    Key? key,
    required this.discipline,
  }) : super(key: key);

  final Discipline discipline;

  @override
  Widget build(BuildContext context) {
    return StudentsOverviewPage(discipline: discipline);
  }
}
