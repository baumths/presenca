import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../../domain/discipline.dart';

part 'discipline_dto.freezed.dart';
part 'discipline_dto.g.dart';

typedef _Json = Map<String, dynamic>;

@freezed
class DisciplineDto with _$DisciplineDto {
  const DisciplineDto._();

  const factory DisciplineDto({
    required String id,
    required String name,
  }) = _DisciplineDto;

  factory DisciplineDto.fromJson(_Json json) => _$DisciplineDtoFromJson(json);

  factory DisciplineDto.fromDomain(Discipline discipline) {
    return DisciplineDto(
      id: discipline.id,
      name: discipline.name,
    );
  }

  Discipline toDomain() {
    return Discipline(
      id: id,
      name: name,
    );
  }
}

class DisciplineDtoAdapter extends TypeAdapter<DisciplineDto> {
  @override
  int get typeId => 0;

  @override
  DisciplineDto read(BinaryReader reader) {
    final decoded = jsonDecode(reader.readString()) as Map;
    final map = Map<String, dynamic>.from(decoded);
    return DisciplineDto.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, DisciplineDto obj) {
    writer.writeString(jsonEncode(obj.toJson()));
  }
}
