import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:uuid/uuid.dart';

import '../../shared/utils.dart' show listEquals;

const Uuid _uuid = Uuid();

class Attendance {
  final String id;
  final String disciplineId;
  final DateTime date;
  final String note;
  final List<String> attendedStudentIds;

  const Attendance({
    required this.id,
    required this.disciplineId,
    required this.date,
    required this.note,
    required this.attendedStudentIds,
  });

  Attendance.empty()
      : this(
          id: _uuid.v1(),
          disciplineId: '',
          date: DateTime.now(),
          note: '',
          attendedStudentIds: const <String>[],
        );

  Attendance.fromMap(Map<String, Object?> map)
      : this(
          id: map['id'] as String,
          disciplineId: map['disciplineId'] as String,
          date: DateTime.parse(map['date'] as String),
          note: map['note'] as String,
          attendedStudentIds: List<String>.from(
            map['attendedStudentIds'] as List,
          ),
        );

  Attendance.fromJson(String json)
      : this.fromMap(Map<String, Object?>.from(jsonDecode(json) as Map));

  Attendance copyWith({
    String? disciplineId,
    DateTime? date,
    String? note,
    List<String>? attendedStudentIds,
  }) {
    return Attendance(
      id: id,
      disciplineId: disciplineId ?? this.disciplineId,
      date: date ?? this.date,
      note: note ?? this.note,
      attendedStudentIds: attendedStudentIds ?? this.attendedStudentIds,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'disciplineId': disciplineId,
      'date': date.toIso8601String(),
      'note': note,
      'attendedStudentIds': attendedStudentIds,
    };
  }

  String toJson() => jsonEncode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Attendance &&
        other.id == id &&
        other.disciplineId == disciplineId &&
        other.date == date &&
        other.note == note &&
        listEquals(other.attendedStudentIds, attendedStudentIds);
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        disciplineId,
        date,
        note,
        Object.hashAll(attendedStudentIds),
      ]);

  @override
  String toString() {
    return 'Attendance('
        'id: $id, '
        'disciplineId: $disciplineId, '
        'date: ${date.toIso8601String()}, '
        'note: $note, '
        'attendedStudentIds, $attendedStudentIds'
        ')';
  }
}
