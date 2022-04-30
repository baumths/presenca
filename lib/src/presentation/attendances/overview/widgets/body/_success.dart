part of 'body.dart';

class AttendancesList extends StatelessWidget {
  const AttendancesList({
    super.key,
    required this.attendances,
  });

  final List<Attendance> attendances;

  @override
  Widget build(BuildContext context) {
    const delegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      mainAxisExtent: 160,
    );

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: delegate,
      itemCount: attendances.length,
      itemBuilder: (context, index) {
        return AttendanceCard(attendance: attendances[index]);
      },
    );
  }
}
