part of 'body.dart';

class StudentsOverview extends StatelessWidget {
  const StudentsOverview({
    Key? key,
    required this.students,
  }) : super(key: key);

  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (BuildContext context, int index) {
        return StudentTile(
          student: students[index],
          tileColor: index.isOdd ? theme.colorScheme.surfaceVariant : null,
        );
      },
    );
  }
}
