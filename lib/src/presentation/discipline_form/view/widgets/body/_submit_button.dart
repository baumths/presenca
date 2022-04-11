part of 'body.dart';

class _SubmitDisciplineButton extends StatelessWidget {
  const _SubmitDisciplineButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisciplineFormBloc, DisciplineFormState>(
      buildWhen: (p, c) => p.canSubmit != c.canSubmit,
      builder: (BuildContext context, DisciplineFormState state) {
        return Hero(
          tag: kCreateDisciplineButtonHeroTag,
          child: PrimaryButton.wide(
            label: 'SALVAR DISCIPLINA',
            onPressed: state.canSubmit
                ? () => context
                    .read<DisciplineFormBloc>()
                    .add(const DisciplineFormEvent.submitted())
                : null,
          ),
        );
      },
    );
  }
}
