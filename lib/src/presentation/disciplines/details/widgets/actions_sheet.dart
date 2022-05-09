import 'package:flutter/material.dart';

import '../../../../domain/discipline.dart';
import '../../../../shared/shared.dart';
import '../../../app/router.dart';
import '../../../pages.dart';

class DisciplineActionsSheet extends StatelessWidget {
  const DisciplineActionsSheet({
    super.key,
    required this.discipline,
  });

  final Discipline discipline;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          dense: true,
          leading: const Icon(Icons.people_alt),
          title: const Text('Editar Alunos'),
          trailing: const Icon(Icons.arrow_forward_rounded),
          onTap: () {
            Navigator.pop(context);
            AppRouter.showStudentsForm(
              context: context,
              discipline: discipline,
            );
          },
        ),
        const Divider(height: 0),
        ListTile(
          dense: true,
          leading: const Icon(Icons.list_alt_rounded),
          title: const Text('Importar Alunos'),
          trailing: const Icon(Icons.arrow_forward_rounded),
          onTap: () async {
            Navigator.pop(context);

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
                discipline: discipline,
              ),
            );
          },
        ),
      ],
    );
  }
}
