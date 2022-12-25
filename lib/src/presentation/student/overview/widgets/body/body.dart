import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../application/student/overview/bloc.dart';
import '../../../../../domain/entities/attendee.dart';
import '../../../../../domain/student.dart';
import '../../../../../shared/shared.dart';

part '_loading.dart';
part '_success.dart';

class StudentOverviewBody extends StatelessWidget {
  const StudentOverviewBody({
    super.key,
    required this.state,
  });

  final StudentOverviewState state;

  @override
  Widget build(BuildContext context) {
    return state.map(
      loadInProgress: (_) => const _LoadingStudent(),
      loadSuccess: (StudentOverviewLoadSuccess state) => StudentOverview(
        student: state.student,
        attendees: state.attendees,
      ),
    );
  }
}
