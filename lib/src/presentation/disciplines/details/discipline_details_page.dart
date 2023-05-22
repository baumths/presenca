import 'package:flutter/material.dart';

import '../../../domain/discipline.dart';
import '../../app/router.dart';
import '../../pages.dart';

class DisciplineDetailsPage extends StatelessWidget {
  const DisciplineDetailsPage({super.key, required this.discipline});

  final Discipline discipline;

  static Route<void> route(Discipline discipline) {
    return MaterialPageRoute(
      builder: (_) => DisciplineDetailsPage(discipline: discipline),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DisciplineDetailsView(discipline: discipline);
  }
}

class DisciplineDetailsView extends StatelessWidget {
  const DisciplineDetailsView({super.key, required this.discipline});

  final Discipline discipline;

  static const List<Widget> tabs = [
    Tab(text: 'Alunos'),
    Tab(text: 'Chamadas'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Text(discipline.name),
          titleTextStyle: theme.textTheme.titleMedium,
          bottom: const TabBar(tabs: tabs),
        ),
        body: TabBarView(
          children: [
            StudentsOverviewPage(discipline: discipline),
            AttendancesOverviewPage(discipline: discipline),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        floatingActionButton: FloatingActionButton(
          heroTag: '_', // Temporary fix for scaffold paint issue
          child: const Icon(Icons.add_task_rounded),
          onPressed: () => AppRouter.showAttendanceForm(context, discipline),
        ),
        bottomNavigationBar: DisciplineDetailsBottomBar(discipline: discipline),
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
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.format_list_bulleted_add),
            tooltip: 'Importar Alunos',
            onPressed: () async {
              await showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (_) => StudentsImportPage(discipline: discipline),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.manage_accounts),
            tooltip: 'Editar Alunos',
            onPressed: () => AppRouter.showStudentsForm(context, discipline),
          ),
          IconButton(
            icon: const Icon(Icons.publish_rounded),
            tooltip: 'Exportar Chamadas',
            onPressed: () async {
              await showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (_) => DisciplineExportPage(discipline: discipline),
              );
            },
          ),
        ],
      ),
    );
  }
}
