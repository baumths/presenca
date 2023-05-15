import 'package:flutter/material.dart';

import '../../../../domain/discipline.dart';
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
    Tab(text: 'Alunos'),
    Tab(text: 'Chamadas'),
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
          tabs: tabs,
        ),
      ),
      body: DisciplineDetailsBody(tabController: tabController),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton(
        heroTag: '_', // Temporary fix for scaffold paint issue
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
                builder: (_) => StudentsImportPage(
                  discipline: discipline,
                ),
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
