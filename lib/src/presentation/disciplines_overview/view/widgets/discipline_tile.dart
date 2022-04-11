import 'package:flutter/material.dart';

import '../../../../domain/entities/discipline.dart';
import '../../../app/router.dart';

class DisciplineTile extends StatelessWidget {
  const DisciplineTile({
    Key? key,
    required this.discipline,
    this.tileColor,
  }) : super(key: key);

  final Discipline discipline;
  final Color? tileColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(discipline.name),
      trailing: const Icon(Icons.arrow_forward_rounded),
      tileColor: tileColor,
      onLongPress: () => AppRouter.showDisciplineForm(context, discipline),
      onTap: () {},
    );
  }
}
