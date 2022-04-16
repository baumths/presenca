part of 'body.dart';

class _EmptyDisciplines extends StatelessWidget {
  const _EmptyDisciplines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(flex: 2),
          const Text(
            'Você ainda não possui nenhuma disciplina.',
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 2),
          Hero(
            tag: kCreateDisciplineButtonHeroTag,
            child: PrimaryButton.wide(
              label: 'CRIAR DISCIPLINA',
              onPressed: () => AppRouter.showDisciplineForm(context, null),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
