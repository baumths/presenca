import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../adapters/hive_adapter.dart';
import '../dtos/student_dto.dart';

class StudentsDataSource extends HiveDataSourceAdapter<StudentDto> {
  static const String kStudentsBoxName = 'students';

  @visibleForTesting
  const StudentsDataSource(LazyBox<StudentDto> box) : super(box);

  static Future<StudentsDataSource> create() async {
    final box = await Hive.openLazyBox<StudentDto>(kStudentsBoxName);
    return StudentsDataSource(box);
  }
}
