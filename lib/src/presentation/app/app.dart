import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/disciplines_repository.dart';
import '../../domain/repositories/students_repository.dart';
import 'router.dart';
import 'theme.dart';

class PresencaApp extends StatelessWidget {
  const PresencaApp({
    Key? key,
    required this.disciplinesRepository,
    required this.studentsRepository,
  }) : super(key: key);

  final DisciplinesRepository disciplinesRepository;
  final StudentsRepository studentsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: disciplinesRepository),
        RepositoryProvider.value(value: studentsRepository),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      routes: AppRouter.routes,
      initialRoute: AppRouter.initialRoute,
    );
  }
}
