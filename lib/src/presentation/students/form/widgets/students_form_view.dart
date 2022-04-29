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
        floatingActionButton: const _SaveFab(),
      ),
    );
  }
}

class _SaveFab extends StatelessWidget {
  const _SaveFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .9,
      child: FloatingActionButton.extended(
        icon: const Icon(Icons.check),
        label: const Text('SALVAR'),
        onPressed: () => context
            .read<StudentsFormBloc>()
            .add(const StudentsFormEvent.submitted()),
      ),
    );
  }
}
