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
      shape: const RoundedRectangleBorder(borderRadius: kDefaultBorderRadius),
      titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      title: const Text('Deseja salvar as alterações?'),
      contentPadding: EdgeInsets.zero,
      contentTextStyle: textTheme.bodySmall?.copyWith(fontSize: 14),
      titleTextStyle: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Divider(height: 0),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('Esta operação não pode ser desfeita.'),
          ),
          Divider(height: 0),
        ],
      ),
      actionsOverflowButtonSpacing: 8,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            'DESCARTAR',
            style: textTheme.caption?.copyWith(
              fontWeight: FontWeight.w500,
              color: colorScheme.error,
            ),
          ),
        ),
        PrimaryButton(
          height: 32,
          label: 'SALVAR',
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }
}
