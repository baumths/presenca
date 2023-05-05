import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/discipline/form/bloc.dart';
import 'name_input.dart';
import 'save_button.dart';

class DisciplineFormBody extends StatelessWidget {
  const DisciplineFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    final bottomPadding = viewInsets.bottom + 16;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const DisciplineNameInput(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              ArchiveButton(),
              DisciplineFormSaveButton(),
            ],
          ),
        ],
      ),
    );
  }
}

class ArchiveButton extends StatelessWidget {
  const ArchiveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisciplineFormBloc, DisciplineFormState>(
      buildWhen: (p, c) => p.discipline.isArchived != c.discipline.isArchived,
      builder: (context, state) {
        final isArchived = state.discipline.isArchived;
        final theme = Theme.of(context);

        return IconButton(
          tooltip: 'Toque para ${isArchived ? 'desarquivar' : 'arquivar'}',
          isSelected: isArchived,
          selectedIcon: const Icon(Icons.unarchive),
          icon: const Icon(Icons.archive_outlined),
          color: theme.colorScheme.secondary,
          padding: const EdgeInsets.all(12),
          style: IconButton.styleFrom(
            backgroundColor: theme.colorScheme.secondaryContainer,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          onPressed: () => context
              .read<DisciplineFormBloc>()
              .add(const DisciplineFormEvent.archivePressed()),
        );
      },
    );
  }
}
