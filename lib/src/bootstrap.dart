import 'dart:io' show Directory;

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'infrastructure/repositories.dart';
import 'presentation/app/app.dart';

Future<Widget> createAndInitializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initHive();

  final disciplinesRepository = await DisciplinesRepositoryImpl.create();
  final studentsRepository = await StudentsRepositoryImpl.create();

  return PresencaApp(
    disciplinesRepository: disciplinesRepository,
    studentsRepository: studentsRepository,
  );
}

Future<void> _initHive() async {
  final Directory supportDir = await getApplicationSupportDirectory();
  Hive.init(supportDir.path);
}
