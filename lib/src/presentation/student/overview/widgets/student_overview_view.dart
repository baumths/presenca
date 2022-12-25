import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/student/overview/bloc.dart';
import 'body/body.dart';

class StudentOverviewView extends StatelessWidget {
  const StudentOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visão Geral'),
        centerTitle: true,
      ),
      body: BlocBuilder<StudentOverviewBloc, StudentOverviewState>(
        builder: (BuildContext context, StudentOverviewState state) {
          return StudentOverviewBody(state: state);
        },
      ),
    );
  }
}
