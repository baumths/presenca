part of 'body.dart';

class AttendancesList extends StatelessWidget {
  const AttendancesList({
    super.key,
    required this.attendances,
  });

  final List<Attendance> attendances;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: AppPadding.allSmall,
      itemCount: attendances.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final attendance = attendances[index];

        return AttendanceCard(
          key: Key(attendance.id),
          attendance: attendance,
        );
      },
    );
  }
}
