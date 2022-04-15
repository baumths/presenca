import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../../domain/student.dart';

part 'student_dto.freezed.dart';
part 'student_dto.g.dart';

typedef _Json = Map<String, dynamic>;

@freezed
class StudentDto with _$StudentDto {
  const StudentDto._();

  const factory StudentDto({
    required String id,
    required String disciplineId,
    required String name,
  }) = _StudentDto;

  factory StudentDto.fromJson(_Json json) => _$StudentDtoFromJson(json);

  factory StudentDto.fromDomain(Student student) {
    return StudentDto(
      id: student.id,
      disciplineId: student.disciplineId,
      name: student.name,
    );
  }

  Student toDomain() {
    return Student(
      id: id,
      disciplineId: disciplineId,
      name: name,
    );
  }
}

class StudentDtoAdapter extends TypeAdapter<StudentDto> {
  @override
  int get typeId => 1;

  @override
  StudentDto read(BinaryReader reader) {
    final decoded = jsonDecode(reader.readString()) as Map;
    final map = Map<String, dynamic>.from(decoded);
    return StudentDto.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, StudentDto obj) {
    writer.writeString(jsonEncode(obj.toJson()));
  }
}
