import '../../domain/entities/attendee.dart';
import '../../domain/entities/student.dart';
import '../../domain/repositories/attendances_repository.dart';
import '../../domain/usecase.dart';

class FindStudentAttendancesUsecase
    implements AsyncUsecase<Student, List<Attendee>> {
  final AttendancesRepository _attendancesRepository;

  const FindStudentAttendancesUsecase({
    required AttendancesRepository attendancesRepository,
  }) : _attendancesRepository = attendancesRepository;

  @override
  Future<List<Attendee>> call(Student student) async {
    final attendances = await _attendancesRepository.find(student.disciplineId);

    final List<Attendee> attendees = [];

    for (final attendance in attendances) {
      final attendee = Attendee(
        studentId: student.id,
        name: student.name,
        date: attendance.date,
        attended: attendance.attendedStudentIds.contains(student.id),
      );
      attendees.add(attendee);
    }

    return attendees;
  }
}
