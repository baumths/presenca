import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/discipline/form/bloc.dart';
import '../../../../shared/shared.dart';
import '../../../app/router.dart';
import '../widgets/body/body.dart';

class DisciplineFormView extends StatelessWidget {
  const DisciplineFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DisciplineFormBloc, DisciplineFormState>(
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

              AppRouter.popUntilDisciplinesOverview(context);
              SnackBarHelper.showSuccess(context, message);
            },
          ),
        );
      },
      buildWhen: (p, c) {
        return p.isSaving != c.isSaving || p.isEditing != c.isEditing;
      },
      builder: (BuildContext context, DisciplineFormState state) {
        Widget title = const Text('Nova Disciplina');

        if (state.isEditing) {
          title = Text('Editando ${state.discipline.name}');
        }

        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(title: title),
              body: DisciplineFormBody(state: state),
            ),
            LoadingOverlay(
              visible: state.isSaving,
              description: 'Salvando Disciplina...',
            ),
          ],
        );
      },
    );
  }
}
