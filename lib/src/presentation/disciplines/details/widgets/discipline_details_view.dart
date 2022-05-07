import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/discipline/details/bloc.dart';
import '../../../../shared/shared.dart';
import 'actions_sheet.dart';
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
    tabController = TabController(length: 2, vsync: this);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            splashRadius: 24,
            tooltip: 'Ações',
            color: colorScheme.onPrimaryContainer,
            icon: const Icon(Icons.call_to_action_rounded),
            onPressed: () async => await showModalBottomSheet<void>(
              context: context,
              builder: (_) {
                final bloc = context.read<DisciplineDetailsBloc>();
                return DisciplineActionsSheet(
                  discipline: bloc.discipline,
                );
              },
            ),
          ),
          const SizedBox(width: 8),
        ],
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
      onPressed: () {},
    );
  }
}
