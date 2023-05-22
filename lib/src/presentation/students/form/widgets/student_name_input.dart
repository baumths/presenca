import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/students/form/bloc.dart';
import '../../../../domain/student.dart';

class StudentNameInput extends StatefulWidget {
  const StudentNameInput({super.key});

  @override
  State<StudentNameInput> createState() => _StudentNameInputState();
}

class _StudentNameInputState extends State<StudentNameInput> {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant StudentNameInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    context.read<StudentsFormBloc>().state.selectedStudent.fold(
      () {},
      (selectedStudent) {
        _textController.text = selectedStudent.name;
        _focusNode.requestFocus();
      },
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onDone() => context
        .read<StudentsFormBloc>()
        .add(StudentsFormEditingComplete(_textController.text));

    return MultiBlocListener(
      listeners: [
        BlocListener<StudentsFormBloc, StudentsFormState>(
          listenWhen: (p, c) => p.students.length < c.students.length,
          listener: (BuildContext context, StudentsFormState state) {
            _textController.clear();
            _focusNode.requestFocus();
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
            _focusNode.requestFocus();
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
              (failure) {
                errorMessage = switch (failure) {
                  StudentFailure.emptyName => state.selectedStudent.fold(
                      () => null,
                      (_) => 'Informe um novo nome para o(a) aluno(a).',
                    ),
                  _ => null,
                };
              },
              (_) {},
            ),
          );

          return TextField(
            style: const TextStyle(fontSize: 14),
            controller: _textController,
            focusNode: _focusNode,
            autofocus: true,
            onEditingComplete: onDone,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: const TextStyle(fontSize: 16),
              border: const UnderlineInputBorder(),
              contentPadding: const EdgeInsets.fromLTRB(16, 4, 0, 4),
              suffixIconConstraints: const BoxConstraints(minWidth: 56),
              errorText: errorMessage,
              suffixIcon: IconButton(
                splashRadius: 24,
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
