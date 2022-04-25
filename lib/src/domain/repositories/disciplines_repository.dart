import 'package:dartz/dartz.dart';

import '../discipline.dart';

abstract class DisciplinesRepository {
  Future<Either<DisciplineFailure, Unit>> save(Discipline discipline);

  Stream<List<Discipline>> watch();
}
