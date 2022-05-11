import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';
import 'body.dart';

class AttendanceFormView extends StatelessWidget {
  const AttendanceFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chamada'),
        centerTitle: true,
        titleSpacing: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            padding: AppPadding.allMedium,
            tooltip: 'Salvar',
            onPressed: () {
              // TODO: submit form
            },
          ),
        ],
      ),
      body: const AttendanceFormBody(),
    );
  }
}
