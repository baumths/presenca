import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:uuid/uuid.dart';

const Uuid _uuid = Uuid();

class Discipline {
  final String id;
  final String name;
  final bool isArchived;

  const Discipline({
    required this.id,
    required this.name,
    required this.isArchived,
  });

  Discipline.empty()
      : this(
          id: _uuid.v1(),
          name: '',
          isArchived: false,
        );

  Discipline.fromMap(Map<String, Object?> map)
      : this(
          id: map['id'] as String,
          name: map['name'] as String,
          isArchived: map['archived'] as bool? ?? false,
        );

  Discipline.fromJson(String json)
      : this.fromMap(
          Map<String, Object?>.from(jsonDecode(json) as Map),
        );

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'archived': isArchived,
    };
  }

  String toJson() => jsonEncode(toMap());

  Discipline copyWith({
    String? name,
    bool? isArchived,
  }) {
    return Discipline(
      id: id,
      name: name ?? this.name,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Discipline &&
        other.id == id &&
        other.name == name &&
        other.isArchived == isArchived;
  }

  @override
  int get hashCode => Object.hashAll([id, name, isArchived]);

  @override
  String toString() => 'Discipline('
      'id: $id, '
      'name: $name, '
      'archived: $isArchived'
      ')';
}
