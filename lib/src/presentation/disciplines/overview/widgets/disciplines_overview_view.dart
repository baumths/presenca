import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/discipline/overview/bloc.dart';
import '../../../app/router.dart';
import 'body/body.dart';

class DisciplineOverviewView extends StatelessWidget {
  const DisciplineOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disciplinas'),
      ),
      body: const DisciplinesOverviewBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const CreateDisciplineFab(),
    );
  }
}

class CreateDisciplineFab extends StatelessWidget {
  const CreateDisciplineFab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisciplinesOverviewBloc, DisciplinesOverviewState>(
      builder: (context, state) => state.maybeWhen(
        orElse: () => const SizedBox(),
        loadSuccess: (_) => FloatingActionButton.extended(
          label: const Text('CRIAR DISCIPLINA'),
          icon: const Icon(Icons.add),
          onPressed: () => AppRouter.showDisciplineForm(context, null),
        ),
      ),
    );
  }
}
