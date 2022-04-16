import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/discipline/overview/bloc.dart';
import '../../../domain/repositories/disciplines_repository.dart';
import 'widgets/disciplines_overview_view.dart';

class DisciplinesOverviewPage extends StatelessWidget {
  const DisciplinesOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DisciplineOverviewBloc>(
      create: (BuildContext context) {
        final DisciplineOverviewBloc bloc = DisciplineOverviewBloc(
          disciplinesRepository: context.read<DisciplinesRepository>(),
        );

        return bloc..add(const DisciplinesOverviewEvent.started());
      },
      child: const DisciplineOverviewView(),
    );
  }
}
