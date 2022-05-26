import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/discipline/form/bloc.dart';

class DisciplineFormSaveButton extends StatelessWidget {
  const DisciplineFormSaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisciplineFormBloc, DisciplineFormState>(
      buildWhen: (p, c) => p.canSubmit != c.canSubmit,
      builder: (context, state) {
        return TextButton(
          onPressed: state.canSubmit
              ? () => context
                  .read<DisciplineFormBloc>()
                  .add(const DisciplineFormEvent.submitted())
              : null,
          child: const Text('Salvar'),
        );
      },
    );
  }
}
