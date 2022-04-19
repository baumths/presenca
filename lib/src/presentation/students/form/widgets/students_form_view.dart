import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';
import 'csv_import_dialog.dart';
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
        final bool? shouldSave = await showDialog<bool>(
          context: context,
          builder: (_) => const DiscardDialog(),
        );

        // TODO: dispatch to bloc
        shouldSave ?? false
            ? SnackBarHelper.showSuccess(context, 'Saved')
            : SnackBarHelper.showError(context, 'Trashed');

        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: const StudentsFormBody(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: const _CsvImportFab(),
      ),
    );
  }
}

class _CsvImportFab extends StatelessWidget {
  const _CsvImportFab({Key? key}) : super(key: key);

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
        label: const Text('IMPORTAR CSV'),
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (_) => const CsvImportDialog(),
          );
        },
      ),
    );
  }
}
