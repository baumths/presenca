import 'package:uuid/uuid.dart';

const Uuid _uuid = Uuid();

class Discipline {
  const Discipline({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory Discipline.empty({String name = ''}) {
    return Discipline(
      id: _uuid.v4(),
      name: name,
      createdAt: DateTime.now(),
    );
  }

  final String id;
  final String name;
  final DateTime createdAt;

  bool validate() => name.isNotEmpty;

  Discipline copyWith({
    String? name,
    DateTime? createdAt,
  }) {
    return Discipline(
      id: id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() => 'Discipline('
      'id: $id, '
      'name: $name, '
      'creationDate: ${createdAt.toIso8601String()}'
      ')';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Discipline &&
        other.id == id &&
        other.name == name &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => Object.hashAll([id, name, createdAt]);
}
