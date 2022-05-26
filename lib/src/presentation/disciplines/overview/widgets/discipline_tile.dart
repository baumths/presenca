import 'package:flutter/material.dart';

import '../../../../domain/entities/discipline.dart';
import '../../../../shared/shared.dart';
import '../../../app/router.dart';

class DisciplineTile extends StatelessWidget {
  const DisciplineTile({
    super.key,
    required this.discipline,
  });

  final Discipline discipline;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTileTheme(
      data: theme.listTileTheme.copyWith(
        shape: kDefaultShapeBorder,
        horizontalTitleGap: 8,
        tileColor: theme.colorScheme.secondaryContainer,
        iconColor: theme.colorScheme.onSecondaryContainer,
        textColor: theme.colorScheme.onSecondaryContainer,
      ),
      child: Padding(
        padding: AppPadding.horizontalSmall,
        child: ListTile(
          title: Text(discipline.name),
          trailing: const Icon(Icons.arrow_forward_rounded),
          onLongPress: () => AppRouter.showDisciplineForm(context, discipline),
          onTap: () => AppRouter.showDisciplineDetails(context, discipline),
        ),
      ),
    );
  }
}
