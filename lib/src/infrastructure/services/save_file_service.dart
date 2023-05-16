import 'dart:io' show Directory, File;

import 'package:csv/csv.dart' show ListToCsvConverter;
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

    Directory? dir;

    // Accessible dir on android (Android/data/com.docsdigitais.presenca/files).
    // For any other platform, use [getApplicationDocumentsDirectory].
    try {
      final externalDir = await getExternalStorageDirectory();
      dir = externalDir ?? await getApplicationDocumentsDirectory();
    } on UnsupportedError {
      dir = await getApplicationDocumentsDirectory();
    }

    File file = File(path.join(dir.path, fileName));
    file = await file.writeAsString(content, flush: true);

    return file.path;
  }
}
