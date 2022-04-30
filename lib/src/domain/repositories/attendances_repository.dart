import 'package:dartz/dartz.dart';

import '../entities/attendance.dart';
import '../failures/attendance_failure.dart';

abstract class AttendancesRepository {
  Future<List<Attendance>> find(String disciplineId);

  Future<Either<AttendanceFailure, Unit>> save(
    String disciplineId,
    List<Attendance> attendances,
  );

  Stream<List<Attendance>> watch(String disciplineId);
}
