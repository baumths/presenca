import 'package:flutter/material.dart';

import '../../../../domain/discipline.dart';
import '../../../../shared/shared.dart';
import '../../../app/router.dart';
import '../../../pages.dart';
import 'body/body.dart';

class DisciplineDetailsView extends StatefulWidget {
  const DisciplineDetailsView({
    super.key,
    required this.discipline,
  });
  final Discipline discipline;

  @override
  State<DisciplineDetailsView> createState() => _DisciplineDetailsViewState();
}

class _DisciplineDetailsViewState extends State<DisciplineDetailsView>
    with SingleTickerProviderStateMixin {
  static const List<Widget> tabs = [
    Text('Alunos'),
    Text('Chamadas'),
  ];

  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(widget.discipline.name),
        titleTextStyle: theme.textTheme.titleMedium,
        bottom: TabBar(
          controller: tabController,
          labelPadding: AppPadding.allSmall,
          labelColor: theme.colorScheme.onSecondaryContainer,
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          splashBorderRadius: kDefaultBorderRadius,
          indicator: ShapeDecoration(
            shape: kDefaultShapeBorder,
            color: theme.colorScheme.secondaryContainer,
          ),
          tabs: tabs,
        ),
      ),
      body: DisciplineDetailsBody(tabController: tabController),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_task_rounded),
        onPressed: () {
          AppRouter.showAttendanceForm(context, widget.discipline);
        },
      ),
      bottomNavigationBar: DisciplineDetailsBottomBar(
        discipline: widget.discipline,
      ),
    );
  }
}

class DisciplineDetailsBottomBar extends StatelessWidget {
  const DisciplineDetailsBottomBar({super.key, required this.discipline});

  final Discipline discipline;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.group_add_rounded),
            tooltip: 'Importar Alunos',
            onPressed: () async {
              await showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                shape: kBottomSheetShapeBorder,
                builder: (_) => StudentsImportPage(
                  discipline: discipline,
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.manage_accounts),
            tooltip: 'Editar Alunos',
            onPressed: () {
              AppRouter.showStudentsForm(
                context: context,
                discipline: discipline,
              );
            },
          ),
          const SizedBox(width: 8),
          IconButton(
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
                  discipline: discipline,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
