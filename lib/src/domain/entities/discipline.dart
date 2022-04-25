import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:uuid/uuid.dart';

const Uuid _uuid = Uuid();

class Discipline {
  final String id;
  final String name;

  const Discipline({
    required this.id,
    required this.name,
  });

  Discipline.empty()
      : this(
          id: _uuid.v1(),
          name: '',
        );

  Discipline.fromMap(Map<String, Object?> map)
      : this(
          id: map['id'] as String,
          name: map['name'] as String,
        );

  Discipline.fromJson(String json)
      : this.fromMap(
          Map<String, Object?>.from(jsonDecode(json) as Map),
        );

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  String toJson() => jsonEncode(toMap());

  Discipline copyWith({
    String? name,
  }) {
    return Discipline(
      id: id,
      name: name ?? this.name,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Discipline && other.id == id && other.name == name;
  }

  @override
  int get hashCode => Object.hashAll([id, name]);

  @override
  String toString() => 'Discipline(id: $id, name: $name)';
}
