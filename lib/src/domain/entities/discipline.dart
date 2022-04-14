import 'package:uuid/uuid.dart';

const Uuid _uuid = Uuid();

class Discipline {
  const Discipline({
    required this.id,
    required this.name,
  });

  factory Discipline.empty({String name = ''}) {
    return Discipline(
      id: _uuid.v1(),
      name: name,
    );
  }

  final String id;
  final String name;

  bool validate() => name.isNotEmpty;

  Discipline copyWith({
    String? name,
  }) {
    return Discipline(
      id: id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'Discipline(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Discipline && other.id == id && other.name == name;
  }

  @override
  int get hashCode => Object.hashAll([id, name]);
}
