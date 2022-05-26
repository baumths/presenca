import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/students/form/bloc.dart';
import 'discard_dialog.dart';
import 'students_form_body.dart';

class StudentsFormView extends StatelessWidget {
  const StudentsFormView({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bool? discardPressed = await showDialog<bool>(
          context: context,
          builder: (_) => const DiscardDialog(),
        );

        return discardPressed ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Text(title),
        ),
        body: const StudentsFormBody(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: const SaveStudentsFormFab(),
      ),
    );
  }
}

class SaveStudentsFormFab extends StatelessWidget {
  const SaveStudentsFormFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: const Icon(Icons.done_rounded, size: 24),
      label: const Text('Salvar'),
      onPressed: () => context
          .read<StudentsFormBloc>()
          .add(const StudentsFormEvent.submitted()),
    );
  }
}
