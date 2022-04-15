import 'package:dartz/dartz.dart';

import '../discipline.dart';

abstract class DisciplinesRepository {
  Future<Option<Discipline>> find(String id);

  Future<List<Discipline>> findAll();

  Future<Either<DisciplineFailure, Unit>> save(Discipline discipline);

  Future<Either<DisciplineFailure, Unit>> delete(String id);

  /// Stream of discipline ids coming from the database.
  Stream<String> watch();
}
