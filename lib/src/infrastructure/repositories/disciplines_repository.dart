import 'package:dartz/dartz.dart';

import '../../domain/discipline.dart';
import '../data_sources.dart';
import '../dtos/discipline_dto.dart';

class DisciplinesRepositoryImpl implements DisciplinesRepository {
  const DisciplinesRepositoryImpl(
    DataSource<DisciplineDto> dataSource,
  ) : _dataSource = dataSource;

  final DataSource<DisciplineDto> _dataSource;

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
      await _dataSource.write(
        discipline.id,
        DisciplineDto.fromDomain(discipline),
      );
      return const Right(unit);
    } on DataSourceException {
      return const Left(DisciplineFailure.unableToUpdate());
    }
  }

  @override
  Future<Either<DisciplineFailure, Unit>> delete(String id) async {
    try {
      await _dataSource.delete(id);
      return const Right(unit);
    } on DataSourceException {
      return const Left(DisciplineFailure.unableToUpdate());
    }
  }

  @override
  Stream<String> watch() => _dataSource.watch();
}
