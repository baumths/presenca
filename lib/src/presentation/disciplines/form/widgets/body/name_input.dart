import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/discipline/form/bloc.dart';

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
