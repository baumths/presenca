import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/discipline/export/cubit.dart';
import '../../../domain/discipline.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../infrastructure/adapters.dart';
import 'widgets/discipline_export_view.dart';

class DisciplineExportPage extends StatelessWidget {
  const DisciplineExportPage({
    super.key,
    required this.discipline,
  });

  final Discipline discipline;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DisciplineExportCubit>(
      create: (_) {
        return DisciplineExportCubit(
          discipline: discipline,
          attendancesRepository: context.read<AttendancesRepository>(),
          studentsRepository: context.read<StudentsRepository>(),
          fileSaverAdapter: context.read<FileSaverAdapter>(),
        );
      },
      child: const DisciplineExportView(),
    );
  }
}
