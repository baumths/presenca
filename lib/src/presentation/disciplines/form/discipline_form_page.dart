import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/discipline/form/bloc.dart';
import '../../../domain/discipline.dart';
import 'widgets/discipline_form_view.dart';

class DisciplineFormPage extends StatelessWidget {
  const DisciplineFormPage({
    Key? key,
    this.editingDiscipline,
  }) : super(key: key);

  final Discipline? editingDiscipline;

  static Route<void> route([Discipline? editingDiscipline]) {
    return MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (_) => DisciplineFormPage(editingDiscipline: editingDiscipline),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DisciplineFormBloc>(
      create: (BuildContext context) {
        final DisciplineFormBloc bloc = DisciplineFormBloc(
          disciplinesRepository: context.read<DisciplinesRepository>(),
        );

        final disciplineOption = optionOf(editingDiscipline);
        final event = DisciplineFormEvent.started(disciplineOption);

        return bloc..add(event);
      },
      child: const DisciplineFormView(),
    );
  }
}
