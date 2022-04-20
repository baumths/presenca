import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

class StudentNameInput extends StatelessWidget {
  const StudentNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: TextField(
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            labelText: 'Adicionar aluno(a)',
            labelStyle: const TextStyle(fontSize: 16),
            border: const UnderlineInputBorder(),
            contentPadding: const EdgeInsets.fromLTRB(16, 4, 0, 4),
            suffixIconConstraints: const BoxConstraints(minWidth: 56),
            suffixIcon: IconButton(
              padding: EdgeInsets.zero,
              splashRadius: 24,
              visualDensity: kVisualDensity,
              icon: const RotatedBox(
                quarterTurns: 1,
                child: Icon(Icons.add_chart),
              ),
              onPressed: () {
                print('');
              },
            ),
          ),
        ),
      ),
    );
  }
}
