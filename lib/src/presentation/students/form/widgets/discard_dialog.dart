import 'package:flutter/material.dart';

class DiscardDialog extends StatelessWidget {
  const DiscardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = TextButton.styleFrom(
      visualDensity: const VisualDensity(horizontal: 2),
    );

    return AlertDialog(
      title: const Text('Deseja descartar as alterações?'),
      content: const Text('Essa operação não pode ser desfeita.'),
      actionsOverflowButtonSpacing: 0,
      buttonPadding: EdgeInsets.zero,
      actions: [
        TextButton(
          style: buttonStyle,
          child: const Text('Descartar'),
          onPressed: () => Navigator.pop(context, true),
        ),
        TextButton(
          style: buttonStyle,
          child: const Text('Cancelar'),
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    );
  }
}
