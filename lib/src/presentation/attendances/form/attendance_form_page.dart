import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/attendances/form/bloc.dart';
import '../../../domain/discipline.dart';
import 'widgets/attendance_form_view.dart';

class AttendanceFormPage extends StatelessWidget {
  const AttendanceFormPage({
    super.key,
    required this.discipline,
  });

  final Discipline discipline;

  static Route<void> route(Discipline discipline) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => AttendanceFormPage(discipline: discipline),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = AttendanceFormBloc();
        return bloc;
      },
      child: const AttendanceFormView(),
    );
  }
}
