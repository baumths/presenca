import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/students/form/bloc.dart';
import 'discard_dialog.dart';
import 'students_form_body.dart';

class StudentsFormView extends StatelessWidget {
  const StudentsFormView({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Remove keyboard before exiting
        FocusScope.of(context).unfocus();

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
          titleTextStyle: Theme.of(context).textTheme.titleMedium,
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
      icon: const Icon(Icons.done_rounded),
      label: const Text('Salvar'),
      onPressed: () => context
          .read<StudentsFormBloc>()
          .add(const StudentsFormEvent.submitted()),
    );
  }
}
