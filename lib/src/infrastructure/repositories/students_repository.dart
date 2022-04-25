import 'package:dartz/dartz.dart';

import '../../domain/student.dart';
import '../data_sources.dart';
import '../dtos/student_dto.dart';

class StudentsRepositoryImpl implements StudentsRepository {
  const StudentsRepositoryImpl(
    DataSource<StudentDto> dataSource,
  ) : _dataSource = dataSource;

  final DataSource<StudentDto> _dataSource;

  @override
  Future<Option<Student>> find(String id) async {
    final dto = await _dataSource.read(id);
    return optionOf(dto?.toDomain());
  }

  @override
  Future<List<Student>> findAllByDisciplineId(String disciplineId) async {
    final List<Student> students = [];
    final allStudentDtos = await _dataSource.readAll();

    for (final StudentDto studentDto in allStudentDtos) {
      if (studentDto.disciplineId == disciplineId) {
        students.add(studentDto.toDomain());
      }
    }

    return students;
  }

  @override
  Future<Either<StudentFailure, Unit>> save(Student student) async {
    try {
      await _dataSource.write(
        student.id,
        StudentDto.fromDomain(student),
      );
      return const Right(unit);
    } on DataSourceException {
      return Left(StudentFailure.unableToUpdate(student: student));
    }
  }

  @override
  Stream<String> watch() => _dataSource.watch();
}
