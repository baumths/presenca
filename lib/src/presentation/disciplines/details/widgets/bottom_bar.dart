import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/discipline/details/bloc.dart';
import '../../../../shared/shared.dart';
import '../../../app/router.dart';
import '../../../pages.dart';

class DisciplineDetailsBottomBar extends StatelessWidget {
  const DisciplineDetailsBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    late final DisciplineDetailsBloc bloc = context.read();

    return BottomBar(
      fab: FloatingActionButton(
        child: const Icon(Icons.add_task_rounded),
        onPressed: () {
          AppRouter.showAttendanceForm(context, bloc.discipline);
        },
      ),
      buttons: [
        BottomBarButton(
          icon: const Icon(Icons.group_add_rounded),
          tooltip: 'Importar Alunos',
          onPressed: () async {
            await showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              shape: kBottomSheetShapeBorder,
              builder: (_) => StudentsImportPage(
                discipline: bloc.discipline,
              ),
            );
          },
        ),
        const SizedBox(width: 8),
        BottomBarButton(
          icon: const Icon(Icons.manage_accounts),
          tooltip: 'Editar Alunos',
          onPressed: () {
            AppRouter.showStudentsForm(
              context: context,
              discipline: bloc.discipline,
            );
          },
        ),
        const SizedBox(width: 8),
        BottomBarButton(
          icon: const RotatedBox(
            quarterTurns: -1,
            child: Icon(Icons.login),
          ),
          tooltip: 'Exportar Chamadas',
          onPressed: () async {
            await showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              shape: kBottomSheetShapeBorder,
              builder: (_) => DisciplineExportPage(
                discipline: bloc.discipline,
              ),
            );
          },
        ),
      ],
    );
  }
}
