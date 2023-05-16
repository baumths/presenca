import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/discipline/export/cubit.dart';
import '../../../domain/discipline.dart';
import '../../../shared/shared.dart';

class DisciplineExportPage extends StatelessWidget {
  const DisciplineExportPage({super.key, required this.discipline});

  final Discipline discipline;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DisciplineExportCubit>(
      create: (context) {
        return DisciplineExportCubit(
          discipline: discipline,
          attendancesRepository: context.read(),
          studentsRepository: context.read(),
          saveFileService: context.read(),
        );
      },
      child: BlocListener<DisciplineExportCubit, DisciplineExportState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (snackBarMessage) {
              if (snackBarMessage != null) {
                SnackBarHelper.showInfo(context, snackBarMessage);
              }
              Navigator.pop(context);
            },
          );
        },
        child: const DisciplineExportView(),
      ),
    );
  }
}

class DisciplineExportView extends StatelessWidget {
  const DisciplineExportView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTextStyle(
      style: theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onSurface,
      ),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BottomSheetDragHandle(),
            Text(
              'Exportação CSV',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 16),
            Text(
              'Ao exportar essa disciplina, um arquivo .csv será criado no seu '
              'dispositivo.',
            ),
            SizedBox(height: 4),
            Text(
              'Esse arquivo será composto por todos os alunos '
              '(incluindo os inativos), e todas as chamadas '
              'dessa disciplina. Detalhes:',
            ),
            SizedBox(height: 4),
            Text(
              '- Uma linha para cada aluno;\n'
              '- Uma coluna para cada chamada;\n'
              '- A última linha é dedicada às anotações.',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'O nome do arquivo será formado pelo nome da disciplina, data e '
              'horário de exportação.',
            ),
            SizedBox(height: 16),
            _ExportButton(),
          ],
        ),
      ),
    );
  }
}

class _ExportButton extends StatelessWidget {
  const _ExportButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<DisciplineExportCubit, DisciplineExportState>(
      builder: (context, state) {
        return FadeUpwardsSwitcher(
          child: SizedBox(
            key: ValueKey(state.isLoading),
            height: kDefaultButtonHeight,
            width: double.infinity,
            child: state.isLoading
                ? const _LoadingIndicator()
                : MaterialButton(
                    color: theme.colorScheme.primary,
                    textColor: theme.colorScheme.onPrimary,
                    shape: kDefaultShapeBorder,
                    child: const Text('Exportar Disciplina'),
                    onPressed: () {
                      context.read<DisciplineExportCubit>().exportDiscipline();
                    },
                  ),
          ),
        );
      },
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      shape: kDefaultShapeBorder,
      color: theme.colorScheme.surfaceVariant.withOpacity(.3),
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Exportando Disciplina',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Text(
                'Isso pode levar alguns segundos...',
                style: TextStyle(fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
