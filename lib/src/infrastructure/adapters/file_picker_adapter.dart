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
      withReadStream: true,
      allowedExtensions: ['csv'],
    );

    if (result == null) {
      return const [];
    }

    final PlatformFile file = result.files.single;
    final Stream<List<int>>? dataStream = file.readStream;

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
