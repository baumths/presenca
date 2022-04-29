import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/discipline/details/bloc.dart';
import '../../../domain/discipline.dart';
import 'widgets/discipline_details_view.dart';

class DisciplineDetailsPage extends StatelessWidget {
  const DisciplineDetailsPage({
    Key? key,
    required this.discipline,
  }) : super(key: key);

  final Discipline discipline;

  static Route<void> route(Discipline discipline) {
    return MaterialPageRoute(
      builder: (_) => DisciplineDetailsPage(discipline: discipline),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DisciplineDetailsBloc>(
      create: (_) {
        final bloc = DisciplineDetailsBloc(discipline: discipline);
        return bloc..add(const DisciplineDetailsEvent.started());
      },
      child: DisciplineDetailsView(title: discipline.name),
    );
  }
}
