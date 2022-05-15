import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/discipline/details/bloc.dart';
import '../../../../shared/shared.dart';
import '../../../app/router.dart';
import '../../../pages.dart';
import 'body/body.dart';

enum DetailsTab {
  students('Alunos', Icons.people_alt_rounded),
  attendances('Chamadas', Icons.calendar_view_day_rounded);

  const DetailsTab(this.label, this.icon);

  final String label;
  final IconData icon;

  static List<Widget> get labels => [for (final it in values) Text(it.label)];
}

class DisciplineDetailsView extends StatefulWidget {
  const DisciplineDetailsView({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<DisciplineDetailsView> createState() => _DisciplineDetailsViewState();
}

class _DisciplineDetailsViewState extends State<DisciplineDetailsView>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: DetailsTab.values.length,
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(widget.title),
        bottom: TabBar(
          controller: tabController,
          labelPadding: AppPadding.allSmall,
          tabs: DetailsTab.labels,
          labelColor: colorScheme.onSurfaceVariant,
          indicatorColor: colorScheme.onSurfaceVariant,
        ),
      ),
      body: DisciplineDetailsBody(tabController: tabController),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: const StartAttendanceFab(),
      bottomNavigationBar: const DisciplineDetailsBottomBar(),
      backgroundColor: colorScheme.surfaceVariant,
    );
  }
}

class DisciplineDetailsBottomBar extends StatelessWidget {
  const DisciplineDetailsBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    late final DisciplineDetailsBloc bloc = context.read();

    return BottomAppBar(
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            const SizedBox(width: 8),
            IconButton(
              iconSize: 24,
              splashRadius: 24,
              tooltip: 'Importar Alunos',
              color: colorScheme.onPrimaryContainer,
              visualDensity: kVisualDensity,
              padding: AppPadding.allSmall,
              icon: const Icon(Icons.group_add_rounded),
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
            IconButton(
              iconSize: 24,
              splashRadius: 24,
              tooltip: 'Editar Alunos',
              color: colorScheme.onPrimaryContainer,
              visualDensity: kVisualDensity,
              padding: AppPadding.allSmall,
              icon: const Icon(Icons.manage_accounts),
              onPressed: () {
                AppRouter.showStudentsForm(
                  context: context,
                  discipline: bloc.discipline,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StartAttendanceFab extends StatelessWidget {
  const StartAttendanceFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add_task_rounded),
      onPressed: () {
        AppRouter.showAttendanceForm(
          context,
          context.read<DisciplineDetailsBloc>().discipline,
        );
      },
    );
  }
}
