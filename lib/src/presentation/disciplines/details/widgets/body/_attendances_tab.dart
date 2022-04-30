part of 'body.dart';

class AttendancesTab extends StatelessWidget {
  const AttendancesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<DisciplineDetailsBloc>();
    return AttendancesOverviewPage(discipline: bloc.discipline);
  }
}
