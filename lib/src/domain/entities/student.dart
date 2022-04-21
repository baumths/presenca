import 'package:uuid/uuid.dart';

const Uuid _uuid = Uuid();

// TODO: Add [bool active] property

class Student {
  const Student({
    required this.id,
    required this.disciplineId,
    required this.name,
  });

  factory Student.empty() {
    return Student(
      id: _uuid.v1(),
      disciplineId: '',
      name: '',
    );
  }

  final String id;
  final String disciplineId;
  final String name;

  bool validate() => name.isNotEmpty;

  Student copyWith({
    String? disciplineId,
    String? name,
  }) {
    return Student(
      id: id,
      disciplineId: disciplineId ?? this.disciplineId,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'Student('
      'id: $id, '
      'disciplineId: $disciplineId, '
      'name: $name'
      ')';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Student &&
        other.id == id &&
        other.disciplineId == disciplineId &&
        other.name == name;
  }

  @override
  int get hashCode => Object.hashAll([id, disciplineId, name]);
}
