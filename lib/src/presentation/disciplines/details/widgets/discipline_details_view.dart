import 'package:flutter/material.dart';

import '../../../../domain/discipline.dart';
import 'body/body.dart';

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
