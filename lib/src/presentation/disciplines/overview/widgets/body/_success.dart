part of 'body.dart';

class DisciplinesOverview extends StatelessWidget {
  const DisciplinesOverview({
    Key? key,
    required this.disciplines,
  }) : super(key: key);

  final List<Discipline> disciplines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      itemCount: disciplines.length,
      itemBuilder: (BuildContext context, int index) {
        return DisciplineTile(
          discipline: disciplines[index],
          tileColor: index.isOdd ? theme.colorScheme.surfaceVariant : null,
        );
      },
    );
  }
}
