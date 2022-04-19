import 'package:flutter/material.dart';

import '../../../domain/discipline.dart';
import 'widgets/students_form_view.dart';

class StudentsFormPage extends StatelessWidget {
  const StudentsFormPage({
    Key? key,
    required this.discipline,
  }) : super(key: key);

  final Discipline discipline;

  static Route<void> route(Discipline discipline) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => StudentsFormPage(discipline: discipline),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StudentsFormView(title: discipline.name);
  }
}
