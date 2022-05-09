import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/attendances/details/bloc.dart';
import 'widgets/attendance_details_view.dart';

class AttendanceDetailsPage extends StatelessWidget {
  const AttendanceDetailsPage({
    super.key,
    required this.bloc,
  });

  final AttendanceDetailsBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: const AttendanceDetailsView(),
    );
  }
}
