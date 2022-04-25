import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:uuid/uuid.dart';

const Uuid _uuid = Uuid();

class Student {
  final String id;
  final String disciplineId;
  final String name;
  final bool active;

  const Student({
    required this.id,
    required this.disciplineId,
    required this.name,
    required this.active,
  });

  factory Student.empty() {
    return Student(
      id: _uuid.v1(),
      disciplineId: '',
      name: '',
      active: true,
    );
  }

  Student.fromMap(Map<String, Object?> map)
      : this(
          id: map['id'] as String,
          disciplineId: map['disciplineId'] as String,
          name: map['name'] as String,
          active: map['active'] as bool,
        );

  Student.fromJson(String json)
      : this.fromMap(
          Map<String, Object?>.from(jsonDecode(json) as Map),
        );

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'disciplineId': disciplineId,
      'name': name,
      'active': active,
    };
  }

  String toJson() => jsonEncode(toMap());

  Student copyWith({
    String? disciplineId,
    String? name,
    bool? active,
  }) {
    return Student(
      id: id,
      disciplineId: disciplineId ?? this.disciplineId,
      name: name ?? this.name,
      active: active ?? this.active,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Student &&
        other.id == id &&
        other.disciplineId == disciplineId &&
        other.name == name &&
        other.active == active;
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        disciplineId,
        name,
        active,
      ]);

  @override
  String toString() => 'Student('
      'id: $id, '
      'disciplineId: $disciplineId, '
      'name: $name'
      'active: $active'
      ')';
}
