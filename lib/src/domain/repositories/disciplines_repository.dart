import 'package:dartz/dartz.dart';

import '../entities/discipline.dart';
import '../failures/disciplines/discipline_failure.dart';

abstract class DisciplinesRepository {
  /// Stream of changes on the database, emits only discipline keys.
  Stream<String> watch();

  Future<Option<Discipline>> find(String id);

  Future<List<Discipline>> findAll();

  Future<Either<DisciplineFailure, Unit>> save(Discipline discipline);

  Future<Either<DisciplineFailure, Unit>> delete(Discipline discipline);
}
