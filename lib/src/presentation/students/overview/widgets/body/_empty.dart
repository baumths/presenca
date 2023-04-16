part of 'body.dart';

class _EmptyStudents extends StatelessWidget {
  const _EmptyStudents({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const Spacer(flex: 8),
          const Text(
            'Essa disciplina ainda não possui alunos.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: colorScheme.secondaryContainer,
              textStyle: TextStyle(color: colorScheme.onSecondaryContainer),
            ),
            onPressed: () {
              final bloc = context.read<StudentsOverviewBloc>();
              AppRouter.showStudentsForm(context, bloc.discipline);
            },
            child: const Text('Cadastrar Alunos'),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
