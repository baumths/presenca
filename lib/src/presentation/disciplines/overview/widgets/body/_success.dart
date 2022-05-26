part of 'body.dart';

class DisciplinesOverview extends StatelessWidget {
  const DisciplinesOverview({
    super.key,
    required this.disciplines,
  });

  final List<Discipline> disciplines;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: disciplines.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (BuildContext context, int index) {
        return DisciplineTile(
          discipline: disciplines[index],
        );
      },
    );
  }
}
