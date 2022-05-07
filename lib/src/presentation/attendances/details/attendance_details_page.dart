import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../application/attendances/details/bloc.dart';
import '../../../domain/attendance.dart';
import '../../../domain/student.dart';
import '../../../shared/shared.dart';
import 'widgets/attendance_details_view.dart';

class AttendanceDetailsPage extends StatelessWidget {
  const AttendanceDetailsPage({
    super.key,
    required this.attendance,
    this.child,
  });

  final Attendance attendance;
  final Widget? child;

  String formattedDate(String locale) {
    return DateFormat.yMMMd(locale).format(attendance.date);
  }

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
            title: formattedDate(context.l10n.localeName),
          ),
    );
  }
}
