import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/discipline/overview/bloc.dart';
import '../../../app/router.dart';
import '../../../settings/settings.dart';
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: const CreateDisciplineFab(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.brush),
              tooltip: 'Tema',
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (_) => const ThemeSettingsView(),
                );
              },
            ),
          ],
        ),
      ),
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
          label: const Text('Criar'),
          icon: const Icon(Icons.add),
          onPressed: () => AppRouter.showDisciplineForm(context, null),
        ),
      ),
    );
  }
}
