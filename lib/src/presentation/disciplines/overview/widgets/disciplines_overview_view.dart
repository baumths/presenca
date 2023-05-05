import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/discipline/overview/bloc.dart';
import '../../../app/router.dart';
import '../../../settings/settings.dart';
import 'disciplines_overview_body.dart';

class DisciplineOverviewView extends StatelessWidget {
  const DisciplineOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text('Disciplinas'),
          ),
          DisciplinesOverviewBody(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: const CreateDisciplineFab(),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.palette_outlined),
              tooltip: 'Tema',
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: ThemeSettingsView.bottomSheetBuilder,
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
