import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/discipline/form/bloc.dart';
import '../../../domain/discipline.dart';
import 'widgets/discipline_form_view.dart';

class DisciplineFormPage extends StatelessWidget {
  const DisciplineFormPage({
    super.key,
    this.editingDiscipline,
  });

  final Discipline? editingDiscipline;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = DisciplineFormBloc(
          disciplinesRepository: context.read(),
        );

        final event = DisciplineFormEvent.started(editingDiscipline);

        return bloc..add(event);
      },
      child: const DisciplineFormView(),
    );
  }
}
