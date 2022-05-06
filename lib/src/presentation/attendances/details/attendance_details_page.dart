import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/attendances/details/bloc.dart';
import '../../../domain/attendance.dart';
import '../../../domain/student.dart';
import 'widgets/attendance_details_view.dart';

class AttendanceDetailsPage extends StatelessWidget {
  const AttendanceDetailsPage({
    super.key,
    required this.attendance,
    this.child,
  });

  final Attendance attendance;
  final Widget? child;

  static Route<void> route(Attendance attendance) {
    return MaterialPageRoute(
      builder: (_) => AttendanceDetailsPage(attendance: attendance),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = AttendanceDetailsBloc(
          attendance: attendance,
          studentsRepository: context.read<StudentsRepository>(),
        );

        return bloc..add(const AttendanceDetailsEvent.started());
      },
      child: child ??
          AttendanceDetailsView(
            title: attendance.date.toString(),
          ),
    );
  }
}
