import 'package:flutter/material.dart';

import '../../../domain/discipline.dart';
import '../../students_overview/students_overview.dart';

class DisciplineDetailsView extends StatelessWidget {
  const DisciplineDetailsView({
    Key? key,
    required this.discipline,
  }) : super(key: key);

  final Discipline discipline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(discipline.name),
      ),
      body: DisciplineDetailsBody(disciplineId: discipline.id),
    );
  }
}

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
