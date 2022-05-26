import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/attendances/details/bloc.dart';
import 'body.dart';

class AttendanceDetailsView extends StatelessWidget {
  const AttendanceDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const AttendanceTitle(),
      ),
      body: const AttendanceDetailsBody(),
    );
  }
}

class AttendanceTitle extends StatelessWidget {
  const AttendanceTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.watch<AttendanceDetailsBloc>().state.dateAndTimeDisplay,
      style: const TextStyle(fontSize: 20),
    );
  }
}
