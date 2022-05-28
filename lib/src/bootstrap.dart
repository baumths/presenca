import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'infrastructure/adapters.dart';
import 'infrastructure/repositories.dart';
import 'infrastructure/services.dart';
import 'presentation/app/app.dart';

Future<Widget> createAndInitializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initHive();

  final attendancesRepository = await AttendancesRepositoryImpl.create();
  final disciplinesRepository = await DisciplinesRepositoryImpl.create();
  final settingsRepository = await SettingsRepositoryImpl.create();
  final studentsRepository = await StudentsRepositoryImpl.create();

  final saveFileService = SaveFileServiceImpl();

  final filePickerAdapter = FilePickerAdapterImpl();

  return PresencaApp(
    attendancesRepository: attendancesRepository,
    disciplinesRepository: disciplinesRepository,
    settingsRepository: settingsRepository,
    studentsRepository: studentsRepository,
    saveFileService: saveFileService,
    filePickerAdapter: filePickerAdapter,
  );
}

Future<void> _initHive() async {
  final supportDir = await getApplicationSupportDirectory();
  Hive.init(supportDir.path);
}
