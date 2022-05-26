import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/attendances/form/bloc.dart';
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
            onPressed: () => context
                .read<AttendanceFormBloc>()
                .add(const AttendanceFormEvent.submitted()),
          ),
        ],
      ),
      body: BlocListener<AttendanceFormBloc, AttendanceFormState>(
        listenWhen: (p, c) {
          return p.saveFailureOrSuccessOption != c.saveFailureOrSuccessOption;
        },
        listener: (_, state) {
          state.saveFailureOrSuccessOption.fold(
            () {
              SnackBarHelper.showError(
                context,
                'Nao foi possível salvar chamada',
              );
            },
            (_) => Navigator.pop(context),
          );
        },
        child: const AttendanceFormBody(),
      ),
    );
  }
}
