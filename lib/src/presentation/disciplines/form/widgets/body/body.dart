import 'package:flutter/material.dart';

import 'name_input.dart';
import 'save_button.dart';

class DisciplineFormBody extends StatelessWidget {
  const DisciplineFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    final bottomPadding = viewInsets.bottom + 8;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          DisciplineNameInput(),
          SizedBox(width: 8),
          DisciplineFormSaveButton(),
        ],
      ),
    );
  }
}
