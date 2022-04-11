import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/discipline.dart';
import '../../../domain/repositories/disciplines_repository.dart';
import '../bloc/discipline_form_bloc.dart';
import 'discipline_form_view.dart';

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

        final event = DisciplineFormInitialized(optionOf(editingDiscipline));
        return bloc..add(event);
      },
      child: const DisciplineFormView(),
    );
  }
}
