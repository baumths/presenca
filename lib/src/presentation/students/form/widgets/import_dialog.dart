import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

// TODO: convert to bottom sheet
class ImportDialog extends StatelessWidget {
  const ImportDialog({Key? key}) : super(key: key);

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            child: SizedBox(
              height: 28,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Importar Alunos',
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (!isLoading)
                    IconButton(
                      splashRadius: 20,
                      iconSize: 20,
                      icon: const Icon(Icons.close),
                      padding: EdgeInsets.zero,
                      visualDensity: kVisualDensity,
                      onPressed: () => Navigator.pop(context),
                    ),
                ],
              ),
            ),
          ),
          const Divider(height: 0),
          isLoading
              ? const LinearProgressIndicator()
              : const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: RichText(
              text: TextSpan(
                style: textTheme.bodySmall,
                children: [
                  const TextSpan(
                    text: 'A importação possui somente suporte para ',
                  ),
                  TextSpan(
                    text: 'arquivos CSV',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const TextSpan(text: ' no momento.'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Ao importar uma planilha, apenas a primeira coluna será '
              'utilizada, o resto será ignorado.'
              '\n\n'
              'Você pode omitir a primeira linha desmarcando a caixinha abaixo '
              'caso haja um cabeçalho.',
              style: textTheme.bodySmall,
            ),
          ),
          const _ChooseFileButton(
            isLoading: isLoading,
          ),
          const Divider(height: 0),
          const _IncludeFirstLineTile(
            value: includeFirstLine,
          ),
        ],
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
    final VoidCallback? onPressed = isLoading
        ? null
        : () {
            // TODO: open native documents
          };

    return PrimaryButton.wide(
      label: 'Escolher Arquivo',
      height: 40,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      onPressed: onPressed,
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
      title: const Text('Incluir Primeira Linha'),
      value: value,
      selected: value,
      onChanged: (_) {
        // TODO: bloc.add(IncludeFirstLineChanged(value))
      },
    );
  }
}
