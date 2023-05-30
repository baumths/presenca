import 'dart:convert' show utf8;

import 'package:csv/csv.dart' show CsvToListConverter;
import 'package:file_picker/file_picker.dart';

abstract class FilePickerAdapter {
  Future<List<List<String>>> pickCsv();
}

class FilePickerAdapterImpl extends FilePickerAdapter {
  @override
  Future<List<List<String>>> pickCsv() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['text/csv', 'csv'],
      withReadStream: true,
    );

    if (result == null || result.files.isEmpty) {
      return const [];
    }

    final Stream<List<int>>? dataStream = result.files.single.readStream;

    if (dataStream == null) {
      return const [];
    }

    final List<List<String>> csv = await dataStream
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .map((row) => row.map((dynamic obj) => '$obj').toList())
        .toList();

    return csv;
  }
}
