import 'dart:io' show Directory;

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'infrastructure/data_sources.dart';
import 'infrastructure/dtos.dart';
import 'infrastructure/repositories.dart';
import 'presentation/app/app.dart';

Future<Widget> createAndInitializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initHive();

  final disciplinesDataSource = await DisciplinesDataSource.create();
  final disciplinesRepository = DisciplinesRepositoryImpl(
    disciplinesDataSource,
  );

  return PresencaApp(
    disciplinesRepository: disciplinesRepository,
  );
}

Future<void> _initHive() async {
  final Directory supportDir = await getApplicationSupportDirectory();
  Hive.init(supportDir.path);

  Hive.registerAdapter<DisciplineDto>(DisciplineDtoAdapter());
}
