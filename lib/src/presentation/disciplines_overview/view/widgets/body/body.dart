import 'package:flutter/material.dart';

import '../../../../../domain/entities/discipline.dart';
import '../../../../../shared/constants.dart';
import '../../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../app/router.dart';
import '../../../bloc/disciplines_overview_bloc.dart';
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
      loading: (_) => const _LoadingDisciplines(),
      success: (DisciplinesOverviewSuccess state) => DisciplinesOverview(
        disciplines: state.disciplines,
      ),
    );
  }
}
