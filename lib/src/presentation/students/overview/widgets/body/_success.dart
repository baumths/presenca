part of 'body.dart';

class StudentsOverview extends StatelessWidget {
  const StudentsOverview({
    Key? key,
    required this.students,
  }) : super(key: key);

  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: students.length,
      padding: AppPadding.allSmall,
      separatorBuilder: (_, __) => const SizedBox(height: 2),
      itemBuilder: (BuildContext context, int index) {
        return StudentTile(
          student: students[index],
        );
      },
    );
  }
}
