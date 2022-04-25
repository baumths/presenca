import 'package:uuid/uuid.dart';

const Uuid _uuid = Uuid();

class Student {
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

  final String id;
  final String disciplineId;
  final String name;
  final bool active;

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
  String toString() => 'Student('
      'id: $id, '
      'disciplineId: $disciplineId, '
      'name: $name'
      'active: $active'
      ')';

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
}
