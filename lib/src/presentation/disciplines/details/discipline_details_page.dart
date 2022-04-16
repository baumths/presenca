import 'package:flutter/material.dart';

import '../../../domain/discipline.dart';
import 'widgets/discipline_details_view.dart';

class DisciplineDetailsPage extends StatelessWidget {
  const DisciplineDetailsPage({
    Key? key,
    required this.discipline,
  }) : super(key: key);

  final Discipline discipline;

  static Route<void> route(Discipline discipline) {
    return MaterialPageRoute(
      builder: (_) => DisciplineDetailsPage(discipline: discipline),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DisciplineDetailsView(discipline: discipline);
  }
}
