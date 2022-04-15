part of 'body.dart';

class _NameFormField extends StatefulWidget {
  const _NameFormField({Key? key}) : super(key: key);

  @override
  State<_NameFormField> createState() => _NameFormFieldState();
}

class _NameFormFieldState extends State<_NameFormField> {
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
    return BlocListener<DisciplineFormBloc, DisciplineFormState>(
      listenWhen: (p, c) => p.isEditing != c.isEditing,
      listener: (BuildContext context, DisciplineFormState state) {
        final String text = state.discipline.name;
        _textController.text = text;

        // Set the cursor to the end of the text
        _textController.selection = TextSelection.collapsed(
          offset: text.length,
        );
      },
      child: BlocConsumer<DisciplineFormBloc, DisciplineFormState>(
        listenWhen: (p, c) => p.isSaving != c.isSaving,
        listener: (BuildContext context, DisciplineFormState state) {
          _focusNode?.requestFocus();
        },
        buildWhen: (p, c) => p.canSubmit != c.canSubmit,
        builder: (BuildContext context, DisciplineFormState state) {
          return TextFormField(
            controller: _textController,
            autofocus: true,
            focusNode: _focusNode,
            decoration: InputDecoration(
              label: const Text('Nome'),
              errorText: state.errorMessage,
              helperText:
                  state.isEditing ? null : 'Dê um nome à sua disciplina.',
            ),
            onChanged: (String text) {
              context
                  .read<DisciplineFormBloc>()
                  .add(DisciplineFormEvent.nameChanged(text));
            },
            onFieldSubmitted: state.canSubmit
                ? (_) {
                    context
                        .read<DisciplineFormBloc>()
                        .add(const DisciplineFormEvent.submitted());
                  }
                : (_) => _focusNode?.requestFocus(),
          );
        },
      ),
    );
  }
}
