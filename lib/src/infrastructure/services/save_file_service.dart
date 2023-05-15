import 'dart:io' show File;

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

abstract class SaveFileService {
  Future<String> saveCsv(String fileName, List<List<String>> content);
}

class SaveFileServiceImpl implements SaveFileService {
  @override
  Future<String> saveCsv(String fileName, List<List<String>> csv) async {
    late final String content = const ListToCsvConverter().convert(csv);
    fileName = fileName.endsWith('.csv') ? fileName : '$fileName.csv';

    final dir = await getApplicationDocumentsDirectory();
    File file = File(path.join(dir.path, fileName));
    file = await file.writeAsString(content, flush: true);

    return file.path;
  }
}
