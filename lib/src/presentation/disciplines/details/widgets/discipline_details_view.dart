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
        titleSpacing: 0,
        title: Text(discipline.name),
      ),
      body: DisciplineDetailsBody(discipline: discipline),
      // floatingActionButton: FloatingActionButton.extended(
      //   label: const Text('EDITAR ALUNOS'),
      //   onPressed: () => AppRouter.showStudentsForm(context, discipline),
      // ),
    );
  }
}
