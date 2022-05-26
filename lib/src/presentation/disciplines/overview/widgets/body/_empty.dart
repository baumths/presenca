part of 'body.dart';

class _EmptyDisciplines extends StatelessWidget {
  const _EmptyDisciplines({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Você ainda não possui nenhuma disciplina.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: colorScheme.secondaryContainer,
                textStyle: TextStyle(color: colorScheme.onSecondaryContainer),
              ),
              onPressed: () => AppRouter.showDisciplineForm(context, null),
              child: const Text('Criar Disciplina'),
            ),
          ],
        ),
      ),
    );
  }
}
