import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/discipline/form/bloc.dart';
import '../../../../shared/shared.dart';
import '../widgets/body/body.dart';

class DisciplineFormView extends StatelessWidget {
  const DisciplineFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DisciplineFormBloc, DisciplineFormState>(
      listenWhen: (p, c) {
        return p.saveFailureOrSuccessOption != c.saveFailureOrSuccessOption;
      },
      listener: (BuildContext context, DisciplineFormState state) {
        state.saveFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) => failure.when(
              unableToUpdate: () {
                final String message = state.isEditing
                    ? 'Não foi possível atualizar a disciplina.'
                    : 'Não foi possível criar a disciplina.';

                SnackBarHelper.showError(context, message);
              },
            ),
            (_) {
              final String message = state.isEditing
                  ? 'Disciplina alterada com sucesso.'
                  : 'Disciplina criada com sucesso.';

              Navigator.pop(context);
              SnackBarHelper.showSuccess(context, message);
            },
          ),
        );
      },
      child: const DisciplineFormBody(),
    );
  }
}
