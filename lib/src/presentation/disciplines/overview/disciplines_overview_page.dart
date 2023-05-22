import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/discipline/overview/bloc.dart';
import '../../../domain/discipline.dart';
import '../../app/router.dart';
import '../../settings/settings.dart';

class DisciplinesOverviewPage extends StatelessWidget {
  const DisciplinesOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DisciplinesOverviewBloc>(
      create: (BuildContext context) {
        final bloc = DisciplinesOverviewBloc(
          disciplinesRepository: context.read<DisciplinesRepository>(),
        );

        return bloc..add(const DisciplinesOverviewStarted());
      },
      child: const DisciplineOverviewView(),
    );
  }
}

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
      builder: (context, state) => switch (state) {
        DisciplinesOverviewLoadSuccess() => FloatingActionButton.extended(
            label: const Text('Criar'),
            icon: const Icon(Icons.add),
            onPressed: () => AppRouter.showDisciplineForm(context, null),
          ),
        _ => const SizedBox(),
      },
    );
  }
}

class DisciplinesOverviewBody extends StatelessWidget {
  const DisciplinesOverviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTileTheme(
      data: theme.listTileTheme.copyWith(
        minVerticalPadding: 8,
        tileColor: theme.colorScheme.surfaceVariant.withOpacity(.3),
        iconColor: theme.colorScheme.onSurfaceVariant,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          side: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
      child: const _DisciplinesList(),
    );
  }
}

class _DisciplinesList extends StatelessWidget {
  const _DisciplinesList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisciplinesOverviewBloc, DisciplinesOverviewState>(
      builder: (context, state) => switch (state) {
        DisciplinesOverviewLoadInProgress() => const SliverToBoxAdapter(
            child: LinearProgressIndicator(),
          ),
        DisciplinesOverviewLoadSuccess state when state.disciplines.isEmpty =>
          const _EmptyDisciplines(),
        DisciplinesOverviewLoadSuccess state => SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverList.separated(
              itemCount: state.disciplines.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (BuildContext context, int index) {
                final discipline = state.disciplines[index];

                return _DisciplineTile(
                  key: Key(discipline.id),
                  discipline: discipline,
                );
              },
            ),
          ),
      },
    );
  }
}

class _DisciplineTile extends StatelessWidget {
  const _DisciplineTile({super.key, required this.discipline});

  final Discipline discipline;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (discipline.isArchived) {
      return ListTile(
        title: Text(discipline.name, style: const TextStyle(fontSize: 14)),
        subtitle: const Text('Arquivada', style: TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.edit_outlined),
        onTap: () => AppRouter.showDisciplineForm(context, discipline),
      );
    }

    return ListTile(
      title: Text(discipline.name),
      trailing: const Icon(Icons.arrow_forward_rounded),
      onLongPress: () => AppRouter.showDisciplineForm(context, discipline),
      onTap: () => AppRouter.showDisciplineDetails(context, discipline),
      tileColor: colorScheme.surfaceVariant,
      iconColor: colorScheme.onSurfaceVariant,
      textColor: colorScheme.onSurfaceVariant,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class _EmptyDisciplines extends StatelessWidget {
  const _EmptyDisciplines();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          const Text(
            'Você ainda não possui nenhuma disciplina.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: colorScheme.secondaryContainer,
              textStyle: TextStyle(color: colorScheme.onSecondaryContainer),
            ),
            child: const Text('Criar Disciplina'),
            onPressed: () => AppRouter.showDisciplineForm(context, null),
          ),
        ]),
      ),
    );
  }
}
