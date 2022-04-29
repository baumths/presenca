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

  static List<Widget> get labels => values.map((it) => Text(it.label)).toList();
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
    return Scaffold(
      appBar: _AppBar(title: widget.title, tabController: tabController),
      body: DisciplineDetailsBody(tabController: tabController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const _StartAttendanceFab(),
      bottomNavigationBar: const _BottomBar(),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    super.key,
    required this.title,
    required this.tabController,
  });

  final String title;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Material(
      color: colorScheme.primary,
      elevation: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const BackButton(),
            iconColor: colorScheme.onPrimary,
            textColor: colorScheme.onPrimary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            horizontalTitleGap: 8,
            title: Text(
              title,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
          TabBar(
            controller: tabController,
            labelPadding: const EdgeInsets.all(8),
            indicatorColor: colorScheme.primary,
            tabs: DetailsTab.labels,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 96);
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surfaceVariant,
      elevation: 20,
      child: SizedBox(
        height: kDefaultButtonHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              splashRadius: 24,
              splashColor: colorScheme.secondary.withOpacity(.2),
              tooltip: 'Ações',
              icon: const Icon(Icons.call_to_action_rounded),
              padding: EdgeInsets.zero,
              color: colorScheme.secondary,
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
      ),
    );
  }
}

class _StartAttendanceFab extends StatelessWidget {
  const _StartAttendanceFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: const Icon(Icons.add_task_rounded),
      onPressed: () {},
    );
  }
}
