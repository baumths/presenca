part of 'body.dart';

class StudentsOverview extends StatelessWidget {
  const StudentsOverview({
    super.key,
    required this.students,
  });

  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: students.length,
      padding: AppPadding.allSmall,
      separatorBuilder: (_, __) => const SizedBox(height: 2),
      itemBuilder: (BuildContext context, int index) {
        final student = students[index];

        return StudentTile(
          key: Key(student.id),
          student: student,
        );
      },
    );
  }
}
