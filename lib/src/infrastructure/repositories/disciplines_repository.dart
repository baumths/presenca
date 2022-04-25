import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../domain/discipline.dart';

class DisciplinesRepositoryImpl implements DisciplinesRepository {
  static const String kDisciplinesBoxName = 'disciplines';

  const DisciplinesRepositoryImpl(
    LazyBox<String> storage,
  ) : _storage = storage;

  static Future<DisciplinesRepository> create() async {
    final box = await Hive.openLazyBox<String>(kDisciplinesBoxName);
    return DisciplinesRepositoryImpl(box);
  }

  final LazyBox<String> _storage;

  @override
  Future<Either<DisciplineFailure, Unit>> save(Discipline discipline) async {
    try {
      await _storage.put(discipline.id, discipline.toJson());
      return const Right(unit);
    } on HiveError {
      return const Left(DisciplineFailure.unableToUpdate());
    }
  }

  @override
  Stream<List<Discipline>> watch() async* {
    yield await findDisciplines();

    await for (final BoxEvent _ in _storage.watch()) {
      yield await findDisciplines();
    }
  }

  Future<List<Discipline>> findDisciplines() async {
    final disciplines = <Discipline>[];

    for (final dynamic key in _storage.keys) {
      final String? json = await _storage.get(key);

      if (json == null) {
        continue;
      }

      disciplines.add(Discipline.fromJson(json));
    }

    return disciplines;
  }
}
