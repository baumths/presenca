import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/discipline/form/bloc.dart';
import '../../../../shared/shared.dart';

class DisciplineFormView extends StatelessWidget {
  const DisciplineFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DisciplineFormBloc, DisciplineFormState>(
      listenWhen: (p, c) {
        return p.saveFailureOrSuccessOption != c.saveFailureOrSuccessOption;
      },
      listener: (BuildContext context, DisciplineFormState state) {
        state.saveFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) => failure.when(
              unableToUpdate: () {
                final String message = state.isEditing
                    ? 'Não foi possível atualizar a disciplina.'
                    : 'Não foi possível criar a disciplina.';

                SnackBarHelper.showError(context, message);
              },
            ),
            (_) {
              final String message = state.isEditing
                  ? 'Disciplina alterada com sucesso.'
                  : 'Disciplina criada com sucesso.';

              Navigator.pop(context);
              SnackBarHelper.showSuccess(context, message);
            },
          ),
        );
      },
      child: const DisciplineFormBody(),
    );
  }
}

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

class DisciplineNameInput extends StatefulWidget {
  const DisciplineNameInput({super.key});

  @override
  State<DisciplineNameInput> createState() => _DisciplineNameInputState();
}

class _DisciplineNameInputState extends State<DisciplineNameInput> {
  late final TextEditingController _textController;
  FocusNode? _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _focusNode = null;
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DisciplineFormBloc, DisciplineFormState>(
      listenWhen: (p, c) => p.isEditing != c.isEditing,
      listener: (BuildContext context, DisciplineFormState state) {
        final String text = state.discipline.name;
        _textController.text = text;

        // Set the carret to the end of the text, it defaults to the start
        _textController.selection = TextSelection.collapsed(
          offset: text.length,
        );
      },
      buildWhen: (p, c) => p.canSubmit != c.canSubmit,
      builder: (BuildContext context, DisciplineFormState state) {
        return TextFormField(
          autofocus: true,
          focusNode: _focusNode,
          controller: _textController,
          style: const TextStyle(fontWeight: FontWeight.w400),
          decoration: const InputDecoration(
            hintText: 'Nova disciplina',
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (String text) {
            context
                .read<DisciplineFormBloc>()
                .add(DisciplineFormEvent.nameChanged(text));
          },
          onFieldSubmitted: (_) {
            if (state.canSubmit) {
              context
                  .read<DisciplineFormBloc>()
                  .add(const DisciplineFormEvent.submitted());
            } else {
              _focusNode?.requestFocus();
            }
          },
        );
      },
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

class DisciplineFormSaveButton extends StatelessWidget {
  const DisciplineFormSaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisciplineFormBloc, DisciplineFormState>(
      buildWhen: (p, c) => p.canSubmit != c.canSubmit,
      builder: (context, state) {
        return TextButton(
          onPressed: state.canSubmit
              ? () => context
                  .read<DisciplineFormBloc>()
                  .add(const DisciplineFormEvent.submitted())
              : null,
          child: const Text('Salvar'),
        );
      },
    );
  }
}
