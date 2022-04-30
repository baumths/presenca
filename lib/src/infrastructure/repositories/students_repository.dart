import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../domain/student.dart';

class StudentsRepositoryImpl implements StudentsRepository {
  static const String kStudentsBoxName = 'students';

  const StudentsRepositoryImpl(
    LazyBox<List> storage,
  ) : _storage = storage;

  static Future<StudentsRepository> create() async {
    final box = await Hive.openLazyBox<List>(kStudentsBoxName);
    return StudentsRepositoryImpl(box);
  }

  final LazyBox<List> _storage;

  @override
  Future<List<Student>> find(String disciplineId) async {
    try {
      final List? students = await _storage.get(disciplineId);

      if (students == null) {
        return <Student>[];
      }

      return studentsFromHive(students);
    } on HiveError {
      return <Student>[];
    }
  }

  @override
  Future<Either<StudentFailure, Unit>> save(
    String disciplineId,
    List<Student> students,
  ) async {
    try {
      await _storage.put(disciplineId, studentsToHive(students));
      return const Right(unit);
    } on HiveError {
      return const Left(StudentFailure.unableToUpdate());
    }
  }

  @override
  Stream<List<Student>> watch(String disciplineId) async* {
    yield await find(disciplineId);

    await for (final BoxEvent _ in _storage.watch(key: disciplineId)) {
      yield await find(disciplineId);
    }
  }

  List<String> studentsToHive(List<Student> students) {
    return students.map((s) => s.toJson()).toList();
  }

  List<Student> studentsFromHive(List hiveList) {
    return <Student>[
      for (final dynamic json in hiveList) Student.fromJson(json as String),
    ];
  }
}
