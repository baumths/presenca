import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/students_overview_bloc.dart';
import 'widgets/body/body.dart';

class StudentsOverviewView extends StatelessWidget {
  const StudentsOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentsOverviewBloc, StudentsOverviewState>(
      builder: (BuildContext context, StudentsOverviewState state) {
        return StudentsOverviewBody(state: state);
      },
    );
  }
}
