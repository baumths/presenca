import 'dart:math' as math show max;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presenca/src/shared/constants.dart';

import '../../../../application/discipline/overview/bloc.dart';
import '../../../../domain/discipline.dart';
import '../../../app/router.dart';

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
          borderRadius: kDefaultBorderRadius,
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
      builder: (context, state) => state.map(
        loadInProgress: (_) => const SliverToBoxAdapter(
          child: LinearProgressIndicator(),
        ),
        loadSuccess: (state) {
          if (state.disciplines.isEmpty) {
            return const _EmptyDisciplines();
          }

          return SliverPadding(
            padding: const EdgeInsets.all(8),
            // TODO: replace by SliverList.separated once it reaches stable
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: math.max(0, state.disciplines.length * 2 - 1),
                (BuildContext context, int index) {
                  final disciplineIndex = index ~/ 2;

                  if (index.isOdd) {
                    return const SizedBox(height: 8);
                  }

                  final discipline = state.disciplines[disciplineIndex];

                  return _DisciplineTile(
                    key: Key(discipline.id),
                    discipline: discipline,
                  );
                },
              ),
            ),
          );
        },
      ),
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
