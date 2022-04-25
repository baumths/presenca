import 'package:dartz/dartz.dart';

import '../student.dart';

abstract class StudentsRepository {
  Future<List<Student>> find(String disciplineId);

  Future<Either<StudentFailure, Unit>> save(
    String disciplineId,
    List<Student> students,
  );

  Stream<List<Student>> watch(String disciplineId);
}
