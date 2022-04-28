import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/students/import/bloc.dart';
import '../../../../shared/shared.dart';
import '../../../app/router.dart';

class StudentsImportBody extends StatelessWidget {
  const StudentsImportBody({Key? key}) : super(key: key);

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
              context: context,
              discipline: discipline,
              initialStudents: students,
            );
          },
        );
      },
      child: const PickFileView(),
    );
  }
}

class PickFileView extends StatelessWidget {
  const PickFileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          _BorderedColumn(
            color: Colors.deepOrange,
            children: [
              _Header(),
              SizedBox(height: 16),
              _HelperMessage(),
            ],
          ),
          SizedBox(height: 16),
          _PickFileButton(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: double.infinity,
      child: Text(
        'Importar Alunos',
        style: textTheme.titleLarge?.copyWith(
          color: colorScheme.secondary,
        ),
      ),
    );
  }
}

class _BorderedColumn extends StatelessWidget {
  const _BorderedColumn({
    Key? key,
    this.color = Colors.black12,
    this.children = const <Widget>[],
  }) : super(key: key);

  final Color color;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2),
        borderRadius: kDefaultBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}

class _HelperMessage extends StatelessWidget {
  const _HelperMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return RichText(
      text: TextSpan(
        style: textTheme.bodyMedium,
        children: [
          const TextSpan(text: 'A importação possui somente suporte para '),
          TextSpan(
            text: 'arquivos CSV',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorScheme.secondary,
            ),
          ),
          const TextSpan(
            text: ' no momento.\n\n',
          ),
          const TextSpan(
            text: 'Ao importar uma planilha, apenas a primeira coluna será '
                'utilizada, as outras serão ignoradas.'
                '\n\n',
          ),
          const TextSpan(
            text: 'Ao realizar a importação, a lista de alunos desta '
                'disciplina será sobrescrita.',
          ),
        ],
      ),
    );
  }
}

class _PickFileButton extends StatelessWidget {
  const _PickFileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kDefaultButtonHeight,
      child: BlocBuilder<StudentsImportBloc, StudentsImportState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const _LoadingIndicator();
          }

          return SizedBox(
            height: kDefaultButtonHeight,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: kDefaultBorderRadius,
                ),
              ),
              child: const Text('Selecionar Arquivo'),
              onPressed: () => context
                  .read<StudentsImportBloc>()
                  .add(const StudentsImportEvent.pickFilePressed()),
            ),
          );
        },
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return SizedBox(
      height: kDefaultButtonHeight,
      child: Row(
        children: [
          const SizedBox(width: 16),
          const SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Processando...',
              style: textTheme.titleSmall?.copyWith(
                color: colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
