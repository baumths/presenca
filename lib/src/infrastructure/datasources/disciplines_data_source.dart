import 'package:hive/hive.dart';

import '../dto/discipline_dto.dart';

class DisciplineException implements Exception {
  const DisciplineException();
}

abstract class DisciplinesDataSource {
  Future<DisciplineDto?> read(String id);

  Future<List<DisciplineDto>> readAll();

  Future<void> write(DisciplineDto discipline);

  Future<void> delete(String id);

  /// Stream of discipline keys coming from database.
  Stream<String> watch();
}

class HiveDisciplinesDataSource implements DisciplinesDataSource {
  static const String kDisciplinesBoxName = 'disciplines';

  HiveDisciplinesDataSource(this.box);

  static Future<DisciplinesDataSource> create([
    String boxName = kDisciplinesBoxName,
  ]) async {
    final box = await Hive.openLazyBox<DisciplineDto>(boxName);
    return HiveDisciplinesDataSource(box);
  }

  final LazyBox<DisciplineDto> box;

  @override
  Future<DisciplineDto?> read(String id) async {
    try {
      return await box.get(id);
    } on HiveError {
      throw const DisciplineException();
    }
  }

  @override
  Future<List<DisciplineDto>> readAll() async {
    final List<DisciplineDto> disciplines = [];

    for (final key in box.keys) {
      final DisciplineDto? discipline = await read(key);

      if (discipline == null) {
        continue;
      }

      disciplines.add(discipline);
    }

    return disciplines;
  }

  @override
  Future<void> write(DisciplineDto discipline) async {
    try {
      await box.put(discipline.id, discipline);
    } on HiveError {
      throw const DisciplineException();
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await box.delete(id);
    } on HiveError {
      throw const DisciplineException();
    }
  }

  @override
  Stream<String> watch() => box.watch().map((event) => event.key as String);
}
