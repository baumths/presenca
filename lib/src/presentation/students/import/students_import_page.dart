import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/students/import/bloc.dart';
import '../../../domain/discipline.dart';
import '../../../infrastructure/adapters.dart';
import 'widgets/students_import_view.dart';

class StudentsImportPage extends StatelessWidget {
  const StudentsImportPage({
    super.key,
    required this.discipline,
  });

  final Discipline discipline;

  static Route<void> route(Discipline discipline) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => StudentsImportPage(discipline: discipline),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentsImportBloc>(
      create: (_) {
        return StudentsImportBloc(
          discipline: discipline,
          filePicker: context.read<FilePickerAdapter>(),
        );
      },
      child: const StudentsImportView(),
    );
  }
}
