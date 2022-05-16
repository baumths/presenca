import 'dart:convert' show utf8;
import 'dart:io' show File;
import 'dart:typed_data' show Uint8List;

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

abstract class FileSaverAdapter {
  Future<String?> saveCsv(String fileName, List<List<String>> content);
}

class FileSaverAdapterImpl implements FileSaverAdapter {
  Future<String?> pickFileLocation(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();

    return await FilePicker.platform.saveFile(
      type: FileType.custom,
      fileName: fileName.endsWith('.csv') ? fileName : '$fileName.csv',
      initialDirectory: dir.path,
      allowedExtensions: ['csv'],
      lockParentWindow: true,
    );
  }

  @override
  Future<String?> saveCsv(String fileName, List<List<String>> csv) async {
    late final String content = const ListToCsvConverter().convert(csv);

    if (kIsWeb) {
      final String path = await FileSaver.instance.saveFile(
        fileName,
        utf8.encode(content) as Uint8List,
        'csv',
        mimeType: MimeType.CSV,
      );

      return path.isEmpty ? null : path;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        // TODO: look into the [share_plus] package

        final String path = await FileSaver.instance.saveAs(
          fileName,
          utf8.encode(content) as Uint8List,
          'csv',
          MimeType.CSV,
        );

        return path.isEmpty ? null : path;
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        final filePath = await pickFileLocation(fileName);

        if (filePath == null) {
          // User canceled
          return null;
        }

        final file = await File(filePath).writeAsString(content);
        return file.path;
      case TargetPlatform.fuchsia:
      default:
        return null;
    }
  }
}
