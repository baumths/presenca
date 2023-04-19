import '../entities/attendee.dart';
import '../entities/student.dart';
import '../repositories/attendances_repository.dart';

abstract class FindStudentAttendancesUsecase {
  const FindStudentAttendancesUsecase();

  Future<List<Attendee>> call(Student student);
}

class FindStudentAttendancesUsecaseImpl extends FindStudentAttendancesUsecase {
  final AttendancesRepository _attendancesRepository;

  const FindStudentAttendancesUsecaseImpl({
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
