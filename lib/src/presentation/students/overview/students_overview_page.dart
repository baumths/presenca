import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/students/overview/bloc.dart';
import '../../../domain/discipline.dart';
import '../../../domain/repositories/students_repository.dart';
import 'widgets/students_overview_view.dart';

class StudentsOverviewPage extends StatelessWidget {
  const StudentsOverviewPage({
    super.key,
    required this.discipline,
  });

  final Discipline discipline;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentsOverviewBloc>(
      create: (BuildContext context) {
        final bloc = StudentsOverviewBloc(
          discipline: discipline,
          studentsRepository: context.read<StudentsRepository>(),
        );

        return bloc..add(const StudentsOverviewEvent.started());
      },
      child: const StudentsOverviewView(),
    );
  }
}
