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
    return BlocBuilder<DisciplinesOverviewBloc, DisciplinesOverviewState>(
      builder: (context, state) => state.map(
        loadInProgress: (_) => const _LoadingDisciplines(),
        loadSuccess: (state) {
          if (state.disciplines.isEmpty) {
            return const _EmptyDisciplines();
          }

          return _DisciplinesList(
            disciplines: state.disciplines,
          );
        },
      ),
    );
  }
}

class _LoadingDisciplines extends StatelessWidget {
  const _LoadingDisciplines();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 156, 16, 0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          addAutomaticKeepAlives: false,
          const [
            Text('Buscando...'),
            SizedBox(height: 20),
            LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class _DisciplinesList extends StatelessWidget {
  const _DisciplinesList({required this.disciplines});

  final List<Discipline> disciplines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTileTheme(
      data: theme.listTileTheme.copyWith(
        tileColor: theme.colorScheme.surfaceVariant.withOpacity(.3),
        iconColor: theme.colorScheme.onSurfaceVariant,
        shape: RoundedRectangleBorder(
          borderRadius: kDefaultBorderRadius,
          side: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
      child: SliverPadding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: disciplines.length,
            (BuildContext context, int index) {
              final discipline = disciplines[index];

              return _DisciplineTile(
                key: Key(discipline.id),
                discipline: discipline,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DisciplineTile extends StatelessWidget {
  const _DisciplineTile({super.key, required this.discipline});

  final Discipline discipline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        title: Text(discipline.name),
        trailing: const Icon(Icons.arrow_forward_rounded),
        onLongPress: () => AppRouter.showDisciplineForm(context, discipline),
        onTap: () => AppRouter.showDisciplineDetails(context, discipline),
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
      padding: const EdgeInsets.fromLTRB(16, 156, 16, 0),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          const Text(
            'A lista de disciplinas está vazia.',
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
