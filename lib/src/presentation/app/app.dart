import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/repositories/repositories.dart';
import '../../infrastructure/adapters.dart';
import 'router.dart';
import 'theme.dart';

class PresencaApp extends StatelessWidget {
  const PresencaApp({
    super.key,
    required this.attendancesRepository,
    required this.disciplinesRepository,
    required this.studentsRepository,
    required this.filePickerAdapter,
  });

  final AttendancesRepository attendancesRepository;
  final DisciplinesRepository disciplinesRepository;
  final StudentsRepository studentsRepository;
  final FilePickerAdapter filePickerAdapter;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: attendancesRepository),
        RepositoryProvider.value(value: disciplinesRepository),
        RepositoryProvider.value(value: studentsRepository),
        RepositoryProvider.value(value: filePickerAdapter),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      title: 'Presença',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: AppRouter.routes,
      initialRoute: AppRouter.initialRoute,
    );
  }
}
