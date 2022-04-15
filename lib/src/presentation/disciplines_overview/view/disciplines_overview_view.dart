import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/constants.dart';
import '../../app/router.dart';
import '../bloc/disciplines_overview_bloc.dart';
import 'widgets/widgets.dart';

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
