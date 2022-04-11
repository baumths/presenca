import 'package:dartz/dartz.dart';

import '../../domain/entities/discipline.dart';
import '../../domain/failures/disciplines/discipline_failure.dart';
import '../../domain/repositories/disciplines_repository.dart';
import '../datasources/disciplines_data_source.dart';
import '../dto/discipline_dto.dart';

class DisciplinesRepositoryImpl implements DisciplinesRepository {
  const DisciplinesRepositoryImpl(
    DisciplinesDataSource dataSource,
  ) : _dataSource = dataSource;

  final DisciplinesDataSource _dataSource;

  @override
  Future<Option<Discipline>> find(String id) async {
    final dto = await _dataSource.read(id);
    return optionOf(dto?.toDomain());
  }

  @override
  Future<List<Discipline>> findAll() async {
    final dtos = await _dataSource.readAll();
    final disciplines = dtos.map((dto) => dto.toDomain()).toList();
    return disciplines;
  }

  @override
  Future<Either<DisciplineFailure, Unit>> save(Discipline discipline) async {
    try {
      await _dataSource.write(DisciplineDto.fromDomain(discipline));
      return const Right(unit);
    } on DisciplineException {
      return const Left(DisciplineFailure.unableToUpdate());
    }
  }

  @override
  Future<Either<DisciplineFailure, Unit>> delete(Discipline discipline) async {
    try {
      await _dataSource.delete(discipline.id);
      return const Right(unit);
    } on DisciplineException {
      return const Left(DisciplineFailure.unableToUpdate());
    }
  }

  @override
  Stream<String> watch() => _dataSource.watch();
}
