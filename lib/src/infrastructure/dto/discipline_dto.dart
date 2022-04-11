import 'dart:convert' show json;

import 'package:hive/hive.dart';

import '../../domain/entities/discipline.dart';

class DisciplineDto {
  const DisciplineDto({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  final String id;
  final String name;
  final DateTime createdAt;

  factory DisciplineDto.fromDomain(Discipline discipline) {
    return DisciplineDto(
      id: discipline.id,
      name: discipline.name,
      createdAt: discipline.createdAt,
    );
  }

  factory DisciplineDto.fromMap(Map<String, dynamic> map) {
    return DisciplineDto(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  factory DisciplineDto.fromJson(String source) {
    return DisciplineDto.fromMap(json.decode(source));
  }

  Discipline toDomain() {
    return Discipline(
      id: id,
      name: name,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'DisciplineDto('
      'id: $id, '
      'name: $name, '
      'createdAt: ${createdAt.toIso8601String()}'
      ')';
}

class DisciplineDtoAdapter extends TypeAdapter<DisciplineDto> {
  @override
  int get typeId => 0;

  @override
  DisciplineDto read(BinaryReader reader) {
    return DisciplineDto.fromJson(reader.readString());
  }

  @override
  void write(BinaryWriter writer, DisciplineDto obj) {
    writer.writeString(obj.toJson());
  }
}
