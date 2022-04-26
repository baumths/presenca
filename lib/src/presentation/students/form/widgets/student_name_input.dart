import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/students/form/bloc.dart';
import '../../../../shared/shared.dart';

class StudentNameInput extends StatefulWidget {
  const StudentNameInput({Key? key}) : super(key: key);

  @override
  State<StudentNameInput> createState() => _StudentNameInputState();
}

class _StudentNameInputState extends State<StudentNameInput> {
  late final TextEditingController _textController;
  FocusNode? _focusNode;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode?.dispose();
    _focusNode = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onDone() {
      final bloc = context.read<StudentsFormBloc>();
      bloc.add(
        StudentsFormEvent.editingComplete(
          name: _textController.text,
        ),
      );
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<StudentsFormBloc, StudentsFormState>(
          listenWhen: (p, c) => p.students.length < c.students.length,
          listener: (BuildContext context, StudentsFormState state) {
            _textController.clear();
            _focusNode?.requestFocus();
          },
        ),
        BlocListener<StudentsFormBloc, StudentsFormState>(
          listenWhen: (p, c) => p.selectedStudent != c.selectedStudent,
          listener: (BuildContext context, StudentsFormState state) {
            final String studentName = state.selectedStudent.fold(
              () => '',
              (student) => student.name,
            );

            _textController.text = studentName;
            _focusNode?.requestFocus();
          },
        ),
      ],
      child: BlocBuilder<StudentsFormBloc, StudentsFormState>(
        buildWhen: (p, c) {
          return p.selectedStudent != c.selectedStudent ||
              p.failureOrSuccessOption != c.failureOrSuccessOption;
        },
        builder: (BuildContext context, StudentsFormState state) {
          String? errorMessage;
          late String labelText;
          late Widget suffixIcon;

          if (state.isEditing) {
            labelText = 'Editando aluno(a)';
            suffixIcon = const Icon(Icons.done);
          } else {
            labelText = 'Adicionar aluno(a)';
            suffixIcon = const RotatedBox(
              quarterTurns: 1,
              child: Icon(Icons.add_chart),
            );
          }

          state.failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) => failure.whenOrNull(
                emptyName: () => state.selectedStudent.fold(
                  () {},
                  (student) {
                    final String name = student.name;
                    errorMessage = 'Por favor, informe um novo nome para $name';
                  },
                ),
              ),
              (_) {},
            ),
          );

          return TextField(
            style: const TextStyle(fontSize: 14),
            controller: _textController,
            focusNode: _focusNode,
            autofocus: true,
            onEditingComplete: onDone,
            onSubmitted: (_) {},
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: const TextStyle(fontSize: 16),
              border: const UnderlineInputBorder(),
              contentPadding: const EdgeInsets.fromLTRB(16, 4, 0, 4),
              suffixIconConstraints: const BoxConstraints(minWidth: 56),
              errorText: errorMessage,
              errorMaxLines: 3,
              suffixIcon: IconButton(
                padding: EdgeInsets.zero,
                splashRadius: 24,
                visualDensity: kVisualDensity,
                onPressed: onDone,
                icon: suffixIcon,
              ),
            ),
          );
        },
      ),
    );
  }
}
