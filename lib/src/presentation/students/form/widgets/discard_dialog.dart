import 'package:flutter/material.dart';

class DiscardDialog extends StatelessWidget {
  const DiscardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Deseja descartar as alterações?'),
      content: const Text('Essa operação não pode ser desfeita.'),
      buttonPadding: EdgeInsets.zero,
      actions: [
        TextButton(
          child: const Text('Descartar'),
          onPressed: () => Navigator.pop(context, true),
        ),
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    );
  }
}
