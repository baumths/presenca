import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/students/import/bloc.dart';
import '../../../domain/discipline.dart';
import '../../../infrastructure/adapters.dart';
import '../../../shared/shared.dart';
import '../../app/router.dart';

class StudentsImportPage extends StatelessWidget {
  const StudentsImportPage({super.key, required this.discipline});

  final Discipline discipline;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentsImportBloc>(
      create: (context) {
        return StudentsImportBloc(
          discipline: discipline,
          filePicker: context.read<FilePickerAdapter>(),
        );
      },
      child: const StudentsImportView(),
    );
  }
}

class StudentsImportView extends StatelessWidget {
  const StudentsImportView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentsImportBloc, StudentsImportState>(
      listenWhen: (p, c) => p.students != c.students,
      listener: (context, state) {
        state.students.fold(
          () {},
          (students) {
            final discipline = context.read<StudentsImportBloc>().discipline;

            Navigator.pop(context);

            AppRouter.showStudentsForm(
              context,
              discipline,
              initialStudents: students,
            );
          },
        );
      },
      child: const StudentsImportBody(),
    );
  }
}

class StudentsImportBody extends StatelessWidget {
  const StudentsImportBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTextStyle(
      style: theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onSurface,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            BottomSheetDragHandle(),
            Text(
              'Importar Lista de Alunos',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 16),
            Text.rich(TextSpan(
              children: [
                TextSpan(text: 'A importação possui somente suporte para '),
                TextSpan(
                  text: 'arquivos CSV',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: ' no momento.'),
              ],
            )),
            SizedBox(height: 8),
            Text(
              'Ao importar uma planilha, apenas a primeira coluna será '
              'utilizada, as outras serão ignoradas.',
            ),
            SizedBox(height: 8),
            Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: 'Atenção! ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'A lista de alunos dessa disciplina será sobrescrita. '
                      'Você poderá descartar as alterações após selecionar o '
                      'arquivo, caso seja necessário.',
                ),
              ],
            )),
            SizedBox(height: 16),
            _PickFileButton(),
          ],
        ),
      ),
    );
  }
}

class _PickFileButton extends StatelessWidget {
  const _PickFileButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<StudentsImportBloc, StudentsImportState>(
      builder: (context, state) {
        return FadeUpwardsSwitcher(
          child: SizedBox(
            key: ValueKey(state.isLoading),
            height: kDefaultButtonHeight,
            width: double.infinity,
            child: state.isLoading
                ? const _LoadingIndicator()
                : MaterialButton(
                    color: theme.colorScheme.primary,
                    textColor: theme.colorScheme.onPrimary,
                    shape: kDefaultShapeBorder,
                    child: const Text('Selecionar Arquivo'),
                    onPressed: () => context
                        .read<StudentsImportBloc>()
                        .add(const StudentsImportEvent.pickFilePressed()),
                  ),
          ),
        );
      },
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surfaceVariant.withOpacity(.3),
      shape: kDefaultShapeBorder,
      child: Row(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          Text('Importando...'),
        ],
      ),
    );
  }
}
