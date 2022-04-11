import 'dart:io' show Directory;

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'infrastructure/datasources/disciplines_data_source.dart';
import 'infrastructure/dto/discipline_dto.dart';
import 'infrastructure/repositories/disciplines_repository.dart';
import 'presentation/app/app.dart';

Future<Widget> createAndInitializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initHive();

  final disciplinesDataSource = await HiveDisciplinesDataSource.create();
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
