import 'package:flutter/material.dart';

import '../../../../../application/discipline/overview/bloc.dart';
import '../../../../../domain/entities/discipline.dart';
import '../../../../../shared/shared.dart';
import '../../../../app/router.dart';
import '../discipline_tile.dart';

part '_empty.dart';
part '_loading.dart';
part '_success.dart';

class DisciplinesOverviewBody extends StatelessWidget {
  const DisciplinesOverviewBody({
    Key? key,
    required this.state,
  }) : super(key: key);

  final DisciplinesOverviewState state;

  @override
  Widget build(BuildContext context) {
    return state.map(
      initial: (_) => const _EmptyDisciplines(),
      loadInProgress: (_) => const _LoadingDisciplines(),
      loadSuccess: (state) => DisciplinesOverview(
        disciplines: state.disciplines,
      ),
    );
  }
}
