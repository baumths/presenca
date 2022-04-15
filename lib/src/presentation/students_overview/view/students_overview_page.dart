import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/students_repository.dart';
import '../bloc/students_overview_bloc.dart';
import 'students_overview_view.dart';

class StudentsOverviewPage extends StatelessWidget {
  const StudentsOverviewPage({
    Key? key,
    required this.disciplineId,
  }) : super(key: key);

  final String disciplineId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentsOverviewBloc>(
      create: (BuildContext context) {
        final bloc = StudentsOverviewBloc(
          disciplineId: disciplineId,
          studentsRepository: context.read<StudentsRepository>(),
        );

        return bloc..add(const StudentsOverviewEvent.initialized());
      },
      child: const StudentsOverviewView(),
    );
  }
}
