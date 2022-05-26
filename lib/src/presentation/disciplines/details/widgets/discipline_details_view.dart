import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';
import 'body/body.dart';
import 'bottom_bar.dart';

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
        title: Text(widget.title),
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
      bottomNavigationBar: const DisciplineDetailsBottomBar(),
    );
  }
}
