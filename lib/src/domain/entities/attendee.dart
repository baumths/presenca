import '../student.dart';

class Attendee {
  final String studentId;
  final String name;
  final DateTime date;
  final bool attended;

  const Attendee({
    required this.studentId,
    required this.name,
    required this.date,
    required this.attended,
  });

  factory Attendee.fromStudent(Student student) {
    return Attendee(
      studentId: student.id,
      name: student.name,
      date: DateTime.now(),
      attended: false,
    );
  }

  Attendee copyWith({bool? attended}) {
    return Attendee(
      studentId: studentId,
      name: name,
      date: date,
      attended: attended ?? this.attended,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Attendee &&
        other.studentId == studentId &&
        other.name == name &&
        other.date == date &&
        other.attended == attended;
  }

  @override
  int get hashCode => Object.hash(studentId, name, date, attended);

  @override
  String toString() => 'Attendee('
      'studentId: $studentId, '
      'name: $name, '
      'date: ${date.toIso8601String()}, '
      'attended: $attended,'
      ')';
}
