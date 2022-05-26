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

    return SizedBox(
      height: 80,
      child: BottomAppBar(
        child: Padding(
          padding: AppPadding.horizontalMedium,
          child: Row(
            children: [
              BottomBarButton(
                icon: const Icon(Icons.group_add_rounded),
                tooltip: 'Importar Alunos',
                onPressed: () async {
                  await showModalBottomSheet<void>(
                    isScrollControlled: true,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: kDefaultBorderRadius.topLeft,
                        topRight: kDefaultBorderRadius.topRight,
                      ),
                    ),
                    context: context,
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
                    shape: RoundedRectangleBorder(
                      borderRadius: kDefaultBorderRadius.copyWith(
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                      ),
                    ),
                    builder: (_) => DisciplineExportPage(
                      discipline: bloc.discipline,
                    ),
                  );
                },
              ),
              const Spacer(),
              FloatingActionButton(
                child: const Icon(Icons.add_task_rounded),
                onPressed: () {
                  AppRouter.showAttendanceForm(context, bloc.discipline);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomBarButton extends StatelessWidget {
  const BottomBarButton({
    super.key,
    required this.icon,
    required this.tooltip,
    this.onPressed,
  });

  final Widget icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      tooltip: tooltip,
      onPressed: onPressed,
      iconSize: 24,
      splashRadius: 24,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }
}
