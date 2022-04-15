import 'package:dartz/dartz.dart';

import '../student.dart';

abstract class StudentsRepository {
  Future<List<Student>> findAllByDisciplineId(String disciplineId);

  Future<Option<Student>> find(String id);

  Future<Either<StudentFailure, Unit>> save(Student student);

  Future<Either<StudentFailure, Unit>> delete(String id);

  /// Stream of student ids coming from the database.
  Stream<String> watch();
}
