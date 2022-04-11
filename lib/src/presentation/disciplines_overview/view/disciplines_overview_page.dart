import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/disciplines_repository.dart';
import '../bloc/disciplines_overview_bloc.dart';
import 'disciplines_overview_view.dart';

class DisciplinesOverviewPage extends StatelessWidget {
  const DisciplinesOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DisciplineOverviewBloc>(
      create: (BuildContext context) {
        final DisciplineOverviewBloc bloc = DisciplineOverviewBloc(
          disciplinesRepository: context.read<DisciplinesRepository>(),
        );

        return bloc..add(const DisciplinesOverviewEvent.initialized());
      },
      child: const DisciplineOverviewView(),
    );
  }
}
