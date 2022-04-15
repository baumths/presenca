import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../adapters/hive_adapter.dart';
import '../dtos/discipline_dto.dart';

class DisciplinesDataSource extends HiveDataSourceAdapter<DisciplineDto> {
  static const String kDisciplinesBoxName = 'disciplines';

  @visibleForTesting
  const DisciplinesDataSource(LazyBox<DisciplineDto> box) : super(box);

  static Future<DisciplinesDataSource> create() async {
    final box = await Hive.openLazyBox<DisciplineDto>(kDisciplinesBoxName);
    return DisciplinesDataSource(box);
  }
}
