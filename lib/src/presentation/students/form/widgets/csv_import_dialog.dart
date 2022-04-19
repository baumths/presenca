import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

class CsvImportDialog extends StatelessWidget {
  const CsvImportDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: state, get from bloc
    const bool includeFirstLine = true;
    const bool isLoading = false;

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: kDefaultBorderRadius),
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Importar Alunos',
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Divider(height: 0),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Ao importar uma planilha CSV, apenas a primeira coluna será '
                'utilizada, o resto será ignorado.\n\n'
                'Você pode omitir a primeira linha caso haja um cabeçalho.',
                style: textTheme.bodySmall,
              ),
            ),
            const _ChooseFileButton(
              isLoading: isLoading,
            ),
            isLoading
                ? const LinearProgressIndicator()
                : const SizedBox(height: 4),
            const Divider(height: 0),
            const _IncludeFirstLineTile(
              value: includeFirstLine,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChooseFileButton extends StatelessWidget {
  const _ChooseFileButton({
    Key? key,
    required this.isLoading,
  }) : super(key: key);

  // TODO: get from bloc
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton.wide(
      label: 'Escolher Arquivo',
      height: 40,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      onPressed: isLoading ? null : () {},
    );
  }
}

class _IncludeFirstLineTile extends StatelessWidget {
  const _IncludeFirstLineTile({
    Key? key,
    required this.value,
  }) : super(key: key);

  // TODO: get from bloc
  final bool value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CheckboxListTile(
      dense: true,
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
      selectedTileColor: colorScheme.secondary.withOpacity(.1),
      activeColor: colorScheme.secondary,
      title: const Text('Incluir primeira linha'),
      value: value,
      selected: value,
      onChanged: (_) {},
    );
  }
}
