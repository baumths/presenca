import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/discipline/overview/bloc.dart';
import '../../../../shared/shared.dart';
import '../../../app/router.dart';
import 'body/body.dart';

class DisciplineOverviewView extends StatelessWidget {
  const DisciplineOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisciplineOverviewBloc, DisciplinesOverviewState>(
      builder: (BuildContext context, DisciplinesOverviewState state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Disciplinas'),
          ),
          body: DisciplinesOverviewBody(state: state),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          floatingActionButton: state.maybeWhen(
            orElse: () => null,
            loadSuccess: (_) => FloatingActionButton.extended(
              label: const Text('CRIAR DISCIPLINA'),
              icon: const Icon(Icons.add),
              shape: const RoundedRectangleBorder(
                borderRadius: kDefaultBorderRadius,
              ),
              onPressed: () => AppRouter.showDisciplineForm(context, null),
            ),
          ),
        );
      },
    );
  }
}
