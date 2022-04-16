import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/students/overview/bloc.dart';
import 'body/body.dart';

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
