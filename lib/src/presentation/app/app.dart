import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../application/settings/theme/cubit.dart';
import '../../domain/repositories/repositories.dart';
import '../../infrastructure/adapters.dart';
import '../../infrastructure/services.dart';
import 'router.dart';
import 'theme.dart';

class PresencaApp extends StatelessWidget {
  const PresencaApp({
    super.key,
    required this.attendancesRepository,
    required this.disciplinesRepository,
    required this.settingsRepository,
    required this.studentsRepository,
    required this.saveFileService,
    required this.filePickerAdapter,
  });

  final AttendancesRepository attendancesRepository;
  final DisciplinesRepository disciplinesRepository;
  final SettingsRepository settingsRepository;
  final StudentsRepository studentsRepository;
  final SaveFileService saveFileService;
  final FilePickerAdapter filePickerAdapter;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: attendancesRepository),
        RepositoryProvider.value(value: disciplinesRepository),
        RepositoryProvider.value(value: settingsRepository),
        RepositoryProvider.value(value: studentsRepository),
        RepositoryProvider.value(value: saveFileService),
        RepositoryProvider.value(value: filePickerAdapter),
      ],
      child: BlocProvider<ThemeSettingsCubit>(
        create: (context) {
          final themeCubit = ThemeSettingsCubit(
            settingsRepository: context.read(),
          );
          return themeCubit..init();
        },
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeSettingsCubit, ThemeSettingsState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: createLightThemeData(state.seedColor),
          darkTheme: createDarkThemeData(state.seedColor),
          themeMode: state.themeMode,
          title: 'Presença',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routes: AppRouter.routes,
          initialRoute: AppRouter.initialRoute,
        );
      },
    );
  }
}
