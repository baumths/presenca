import 'package:intl/intl.dart';

import '../../../domain/attendance.dart';
import '../../../domain/discipline.dart';
import '../../../domain/student.dart';

class DisciplineAggregate {
  static final RegExp fileNameRegEx = RegExp(r'[^\w\p{L}]', unicode: true);

  static final DateFormat timestampDateFormat = DateFormat('dd-MM-yyyy_HH-mm');
  static final DateFormat attendanceDateFormat = DateFormat('dd/MM/yyyy HH:mm');

  // Tags used when creating/parsing the aggragated CSV table.
  static const String nameTag = 'Nome';
  static const String notesTag = 'Anotações';
  static const String attendedTag = 'Presente';
  static const String inactiveTag = '(Inativo)';

  const DisciplineAggregate({
    required this.discipline,
    required this.students,
    required this.attendances,
  });

  final List<Student> students;
  final List<Attendance> attendances;
  final Discipline discipline;

  String get fileName => discipline.name
      .replaceAll(' ', '-')
      .replaceAll(fileNameRegEx, '')
      .toLowerCase();

  String get timestamp => timestampDateFormat.format(DateTime.now());

  String get timestampedFileName => '${fileName}_$timestamp';

  List<List<String>> toCsv() {
    return [
      _buildHeaders(),
      ..._generateStudentRows(),
      _buildNotesRow(),
    ];
  }

  List<String> _buildHeaders() {
    final header = <String>[nameTag];

    for (final attendance in attendances) {
      header.add(attendanceDateFormat.format(attendance.date));
    }

    return header;
  }

  List<String> _buildNotesRow() {
    final notes = <String>[notesTag];

    for (final attendance in attendances) {
      notes.add(attendance.note);
    }

    return notes;
  }

  Iterable<List<String>> _generateStudentRows() sync* {
    // TODO: cache attendance.attendedStudentIds removing already checked ids.
    for (final student in students) {
      final studentRow = [
        student.active ? student.name : '${student.name} $inactiveTag',
      ];

      for (final attendance in attendances) {
        if (attendance.attendedStudentIds.contains(student.id)) {
          studentRow.add(attendedTag);
        } else {
          studentRow.add('');
        }
      }

      yield studentRow;
    }
  }

  // TODO(future): split & improve this method
  /// Expected format:
  ///
  /// ```txt
  /// Students                         Attendances ────────────── Example ──────── N ─▶
  ///    │    | `nameTag`            | "dd/MM/yyyy HH:mm"  | "01/01/1970 00:00" | ... |
  ///    │    | "John"               | `attendedTag` or "" | `attendedTag`      | ... |
  ///    │    | "Mary `inactiveTag`" | `attendedTag` or "" | ""                 | ... |
  ///    N    | ...                  | ...                 | ...                | ... |
  ///    ▼    | `notesTag`           | ""                  | "Some note"        | ... |
  /// ```
  ///
  /// The span at `table[0][0]` must be [DisciplineAggregate.nameTag].
  /// The span at `table[table.length][0]` must be [DisciplineAggregate.notesTag].
  ///
  /// The simples accepted table is: `[[nameTag][notesTag]]`.
  ///
  /// - Returns an [InvalidTableFormat] failure if [table] does not match the
  /// `[[nameTag, ...], ..., [notesTag, ...]]` pattern .
  /// - Returns an [InvalidAttendanceDateFormat] failure if [attendanceDateFormat.parse]
  /// fails to parse any attendance date & time by throwing a [FormatException].
  static (DisciplineCsvParsingFailure?, DisciplineAggregate?) parseCsv(
    Discipline discipline,
    List<List<String>> table,
  ) {
    final isExpectedFormat = switch (table) {
      [[nameTag, ...], ..., [notesTag, ...]] => true,
      _ => false,
    };

    if (!isExpectedFormat) {
      return (const InvalidTableFormat(), null);
    }

    final header = table[0];
    final footer = table[table.length - 1];
    final studentCount = table.length - 2;

    final students = <Student>[];
    final attendances = <Attendance>[];

    for (int row = 1; row <= studentCount; ++row) {
      String name = table[row][0];
      bool active = true;

      if (name.contains(inactiveTag)) {
        active = false;
        name = name.replaceAll(inactiveTag, '').trim();
      }

      final student = Student.empty().copyWith(
        disciplineId: discipline.id,
        name: name,
        active: active,
      );

      students.add(student);
    }

    assert(students.length == studentCount);

    for (int col = 1; col < header.length; ++col) {
      final attendedStudentIds = <String>[];

      for (int row = 1; row <= studentCount; ++row) {
        if (table[row][col].isNotEmpty) {
          final student = students[row - 1];
          assert(table[row][0].contains(student.name));
          attendedStudentIds.add(student.id);
        }
      }

      try {
        final attendance = Attendance.empty().copyWith(
          disciplineId: discipline.id,
          date: attendanceDateFormat.parse(header[col]),
          note: footer[col],
          attendedStudentIds: attendedStudentIds,
        );

        attendances.add(attendance);
      } on FormatException {
        assert(attendanceDateFormat.pattern != null);
        return (
          InvalidAttendanceDateFormat(
            expected: attendanceDateFormat.pattern!,
            actual: header[col],
            column: col,
          ),
          null
        );
      }
    }

    return (
      null,
      DisciplineAggregate(
        discipline: discipline,
        students: students,
        attendances: attendances,
      )
    );
  }
}

sealed class DisciplineCsvParsingFailure {
  const DisciplineCsvParsingFailure();
}

final class InvalidTableFormat extends DisciplineCsvParsingFailure {
  const InvalidTableFormat();
}

final class InvalidAttendanceDateFormat extends DisciplineCsvParsingFailure {
  const InvalidAttendanceDateFormat({
    required this.expected,
    required this.actual,
    required this.column,
  });

  final String expected;
  final String actual;

  /// Zero indexed
  final int column;
}
