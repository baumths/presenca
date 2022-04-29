part of 'body.dart';

class StudentsTab extends StatelessWidget {
  const StudentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<DisciplineDetailsBloc>();
    return StudentsOverviewPage(discipline: bloc.discipline);
  }
}
