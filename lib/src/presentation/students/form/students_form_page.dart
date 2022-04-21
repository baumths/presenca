import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/students/form/bloc.dart';
import '../../../domain/discipline.dart';
import '../../../domain/student.dart';
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
    return BlocProvider<StudentsFormBloc>(
      create: (_) {
        final bloc = StudentsFormBloc(
          studentsRepository: context.read<StudentsRepository>(),
        );

        return bloc..add(StudentsFormEvent.started(discipline: discipline));
      },
      child: StudentsFormView(title: discipline.name),
    );
  }
}
