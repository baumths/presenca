import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

class DiscardDialog extends StatelessWidget {
  const DiscardDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      titlePadding: const EdgeInsets.all(16),
      contentPadding: EdgeInsets.zero,
      title: const Text('Deseja salvar as alterações?'),
      titleTextStyle: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      actionsOverflowButtonSpacing: 8,
      actions: [
        TextButton(
          child: Text(
            'DESCARTAR',
            style: textTheme.caption?.copyWith(
              fontWeight: FontWeight.w500,
              color: colorScheme.error,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, false);
            // TODO: trash changes
          },
        ),
        PrimaryButton(
          label: 'SALVAR',
          height: 32,
          onPressed: () {
            Navigator.pop(context, true);
            // TODO: save students
          },
        ),
      ],
    );
  }
}
