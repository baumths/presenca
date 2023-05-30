import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/application/discipline/form/bloc.dart';

class ImportButton extends StatelessWidget {
  const ImportButton({super.key});

  static const _buttonKey = Key('<discipline-import-button>');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DisciplineFormBloc, DisciplineFormState>(
      listenWhen: (p, c) => p.importResult != c.importResult,
      listener: (_, c) async {
        final bloc = context.read<DisciplineFormBloc>();

        if (c.importResult case DisciplineImportFailure failure) {
          await showDialog<void>(
            context: context,
            builder: (_) => DisciplineImportFailedDialog(failure: failure),
          );
          bloc.add(const DisciplineFormImportReset());
        }
      },
      builder: (context, state) {
        if (state.isEditing) {
          return const SizedBox.shrink();
        }
        final colorScheme = Theme.of(context).colorScheme;

        return switch (state.importResult) {
          DisciplineImportInitial() => IconButton.filledTonal(
              key: _buttonKey,
              tooltip: 'Importar Disciplina',
              icon: const Icon(Icons.file_open_outlined),
              isSelected: false,
              onPressed: () => context
                  .read<DisciplineFormBloc>()
                  .add(const DisciplineFormImportPressed()),
            ),
          DisciplineImportLoading() => const IconButton.filledTonal(
              key: _buttonKey,
              onPressed: null,
              icon: LimitedBox(
                maxWidth: 20,
                maxHeight: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          DisciplineImportFailure() => IconButton.filledTonal(
              key: _buttonKey,
              tooltip: 'Falha na Importação',
              onPressed: null,
              icon: const Icon(Icons.warning_rounded),
              style: IconButton.styleFrom(
                disabledBackgroundColor: colorScheme.error,
                disabledForegroundColor: colorScheme.onError,
              ),
            ),
          DisciplineImportSuccess result => IconButton.filledTonal(
              key: _buttonKey,
              tooltip: 'Importando',
              isSelected: true,
              icon: const Icon(Icons.file_open),
              onPressed: () async {
                final bloc = context.read<DisciplineFormBloc>();

                final discardPressed = await showDialog<bool>(
                  context: context,
                  builder: (_) => DisciplineImportInfoDialog(result: result),
                );

                if ((discardPressed ?? false) && context.mounted) {
                  bloc.add(const DisciplineFormImportReset());
                }
              },
            ),
        };
      },
    );
  }
}

class DisciplineImportInfoDialog extends StatelessWidget {
  const DisciplineImportInfoDialog({super.key, required this.result});

  final DisciplineImportSuccess result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      icon: const Icon(Icons.check_circle_outlined, size: 48),
      iconColor: theme.colorScheme.onSurface,
      title: const Text('Importando Disciplina'),
      content: DefaultTextStyle(
        style: theme.textTheme.bodyLarge!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Alunos: ${result.students.length}'),
            Text('Chamadas: ${result.attendances.length}'),
          ],
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.error,
          ),
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Descartar'),
        ),
        FilledButton.tonal(
          child: const Text('Manter'),
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    );
  }
}

class DisciplineImportFailedDialog extends StatelessWidget {
  const DisciplineImportFailedDialog({super.key, required this.failure});

  final DisciplineImportFailure failure;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      scrollable: true,
      title: const Text('Falha na Importação'),
      titlePadding: EdgeInsets.zero,
      icon: const Icon(Icons.warning_rounded, size: 40),
      iconColor: colorScheme.error,
      iconPadding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 12),
      contentPadding: const EdgeInsets.only(bottom: 24),
      content: Column(children: [
        const Divider(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            failure.message,
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const Divider(height: 24),
        const Text('Tabela de Exemplo', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 12),
        const SampleImportTable(),
      ]),
    );
  }
}

class SampleImportTable extends StatelessWidget {
  const SampleImportTable({super.key});

  @override
  Widget build(BuildContext context) {
    final tableBorderSide = BorderSide(
      color: Theme.of(context).colorScheme.outlineVariant,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        dataRowMinHeight: 24,
        dataRowMaxHeight: 32,
        headingRowHeight: 32,
        columnSpacing: 16,
        border: TableBorder(
          top: tableBorderSide,
          bottom: tableBorderSide,
          horizontalInside: tableBorderSide,
          verticalInside: tableBorderSide,
        ),
        columns: const [
          DataColumn(label: Text('Nome')),
          DataColumn(label: Text('DD/MM/AAAA HH:MM')),
          DataColumn(label: Text('01/01/2000 00:00')),
        ],
        rows: const [
          DataRow(cells: [
            DataCell(Text('Fulano')),
            DataCell(Text('')),
            DataCell(Text('Presente')),
          ]),
          DataRow(cells: [
            DataCell(Text('Ciclano')),
            DataCell(Text('Presente')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text(
              'Anotações',
              style: TextStyle(fontWeight: FontWeight.w500),
            )),
            DataCell(Text('')),
            DataCell(Text('...')),
          ]),
        ],
      ),
    );
  }
}
