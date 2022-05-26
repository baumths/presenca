import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/discipline/overview/bloc.dart';
import '../../../../../domain/entities/discipline.dart';
import '../../../../app/router.dart';
import '../discipline_tile.dart';

part '_empty.dart';
part '_loading.dart';
part '_success.dart';

class DisciplinesOverviewBody extends StatelessWidget {
  const DisciplinesOverviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisciplinesOverviewBloc, DisciplinesOverviewState>(
      builder: (context, state) => state.map(
        loadInProgress: (_) => const _LoadingDisciplines(),
        loadSuccess: (state) {
          if (state.disciplines.isEmpty) {
            return const _EmptyDisciplines();
          }

          return DisciplinesOverview(
            disciplines: state.disciplines,
          );
        },
      ),
    );
  }
}
