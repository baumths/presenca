import 'dart:io' show File;

import 'package:csv/csv.dart' show CsvToListConverter;
import 'package:file_picker/file_picker.dart';

abstract class FilePickerAdapter {
  Future<List<List<String>>> pickCsv();
}

const _csvToListConverter = CsvToListConverter(
  shouldParseNumbers: false,
);

class FilePickerAdapterImpl extends FilePickerAdapter {
  @override
  Future<List<List<String>>> pickCsv() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['text/csv', 'csv'],
    );

    if (result == null || result.files.isEmpty) {
      return const [];
    }

    try {
      final content = await File(result.files.single.path!).readAsString();
      return _csvToListConverter.convert<String>(content);
    } on Exception {
      return const [];
    }
  }
}
