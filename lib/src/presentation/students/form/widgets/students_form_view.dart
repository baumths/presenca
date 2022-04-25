import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/students/form/bloc.dart';
import '../../../../shared/shared.dart';
import 'import_dialog.dart';
import 'discard_dialog.dart';
import 'students_form_body.dart';

class StudentsFormView extends StatelessWidget {
  static const _kFabLocation = FloatingActionButtonLocation.centerFloat;

  const StudentsFormView({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bool? shouldSave = await showDialog<bool>(
          context: context,
          builder: (_) => const DiscardDialog(),
        );

        // TODO: show loading overlay
        if (shouldSave == null) {
          return false;
        } else if (shouldSave) {
          context
              .read<StudentsFormBloc>()
              .add(const StudentsFormEvent.submitted());
          SnackBarHelper.showSuccess(context, 'Saved');
        } else {
          SnackBarHelper.showError(context, 'Trashed');
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(title), titleSpacing: 0),
        body: const StudentsFormBody(),
        floatingActionButtonLocation: _kFabLocation,
        floatingActionButton: const _ImportFab(),
      ),
    );
  }
}

class _ImportFab extends StatelessWidget {
  const _ImportFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .8,
      child: FloatingActionButton.extended(
        // TODO(future): update on scrollable scrolled
        isExtended: true,
        icon: const RotatedBox(
          quarterTurns: 1,
          child: Icon(Icons.poll_outlined),
        ),
        label: const Text('IMPORTAR'),
        onPressed: () async {
          await showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (_) => const ImportDialog(),
          );
        },
      ),
    );
  }
}
